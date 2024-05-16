

include("token.cmake")
set(headers "-Headers @{Authorization=\"Bearer ${token}\"}" )

macro(get_new_version_from_pypi)
    string(REGEX MATCH "PACKAGE_NAME +([^ ]+)" package_name "${portfile_contents}")
    string(REGEX REPLACE "PACKAGE_NAME +" "" package_name "${package_name}")
    string(REGEX REPLACE "( |\n|\r)" "" package_name "${package_name}") # sanitze package_name
    message(STATUS "Found package name from portfile: ${package_name}")
    execute_process(COMMAND ${pwsh_path} -C "Invoke-WebRequest -Uri \"https://pypi.python.org/pypi/${package_name}/json/\" -Method GET | ConvertFrom-Json | Select-Object -ExpandProperty info | Select-Object -ExpandProperty version"
                OUTPUT_VARIABLE upstream_version
                ERROR_VARIABLE err)
    if(err OR upstream_version STREQUAL "")
      message(STATUS "--- unable to get version: ${err}")
      list(APPEND not_update_able "${port_name}")
      continue()
    endif()
    string(REPLACE "\n" "" upstream_version "${upstream_tag}")
    string(STRIP "${upstream_version}" upstream_version)
    message(STATUS "\nUpstream version is: ${upstream_version}\n")
    if(upstream_version GREATER version)
      message(STATUS "--- ${port_name} has version ${version} vs ${upstream_version}")
      list(APPEND update_able "${port_name}")
    else()
      list(APPEND up_to_date "${port_name}")
      continue()
    endif()
    
    string(SUBSTRING "${package_name}" 0 1 _PACKAGE_PcREFIX)
    file(DOWNLOAD "https://files.pythonhosted.org/packages/source/${_PACKAGE_PREFIX}/${package_name}/${package_name}-${upstream_version}.tar.gz" "${downloads}${package_name}-${upstream_version}.tar.gz" SHOW_PROGRESS)
    file(SHA512 "${downloads}${package_name}-${upstream_version}.tar.gz" new_sha)#

    if(add_python_test_import)
      set(extra "\nvcpkg_python_test_import(MODULE \"${package_name}\")\n")
    endif()

    #string(JSON new_manifest_json SET "${manifest_json}" "${ver_member}" "${upstream_version}")
    string(REPLACE "${version}" "${upstream_version}" new_manifest_json "${manifest_json}")
    file(WRITE "${port}/vcpkg.json" "${new_manifest_json}")
    string(REGEX REPLACE "SHA512( +)([a-zA-Z0-9]+)" "SHA512\\1${new_sha}" new_portfle_contents "${portfile_contents}")
    file(WRITE "${port}/portfile.cmake" "${new_portfle_contents}${extra}")
endmacro()

macro(get_new_version_from_github)
    string(REGEX MATCH "REPO +([^ \n]+)" repo "${portfile_contents}")
    string(REGEX REPLACE "REPO +" "" repo "${repo}")
    message(STATUS "Found repo name from portfile: ${repo}")
    execute_process(COMMAND ${pwsh_path} -C "Invoke-WebRequest -Uri \"https://api.github.com/repos/${repo}/releases/latest\" ${headers} | ConvertFrom-Json | Select-Object -ExpandProperty tag_name"
                OUTPUT_VARIABLE upstream_tag
                ERROR_VARIABLE err
                )
    if(err)
      execute_process(COMMAND ${pwsh_path} -C "(Invoke-WebRequest -Uri \"https://api.github.com/repos/${repo}/tags\" ${headers} | ConvertFrom-Json)[0].name"
              OUTPUT_VARIABLE upstream_tag
              ERROR_VARIABLE err
              )
      if(err OR upstream_tag STREQUAL "")
        message(STATUS "--- unable to get version: ${err}")
        list(APPEND not_update_able "${port_name}")
        continue()
      endif()
    endif()
    string(REPLACE "v" "" upstream_version "${upstream_tag}")
    string(STRIP "${upstream_tag}" upstream_tag)
    string(REPLACE "\n" "" upstream_tag "${upstream_tag}")

    string(STRIP "${upstream_version}" upstream_version)
    message(STATUS "\nUpstream version is: ${upstream_version}\n")
    if(upstream_version GREATER version)
      message(STATUS "--- ${port_name} has version ${version} vs ${upstream_version}")
      list(APPEND update_able "${port_name}")
      set(update TRUE)
    else()
      list(APPEND up_to_date "${port_name}")
      continue()
    endif()

    set(github_host "https://github.com")
    if(NOT repo MATCHES "^([^/]*)/([^/]*)$")
        message(FATAL_ERROR "REPO (${repo}) is not a valid repo name:
    must be an organization name followed by a repository name separated by a single slash.")
    endif()
    set(org_name "${CMAKE_MATCH_1}")
    set(repo_name "${CMAKE_MATCH_2}")
    set(ref_to_use "${upstream_tag}")
  
    string(REPLACE "/" "_-" sanitized_ref "${upstream_tag}")
    set(filename ${org_name}-${repo_name}-${sanitized_ref}.tar.gz)
    message(STATUS "${downloads}${filename} from ${github_host}/${org_name}/${repo_name}/archive/${ref_to_use}.tar.gz")
    file(DOWNLOAD "${github_host}/${org_name}/${repo_name}/archive/${ref_to_use}.tar.gz" "${downloads}${filename}" SHOW_PROGRESS)
    file(SHA512 "${downloads}${filename}" new_sha)#

    if(add_python_test_import)
      set(extra "\nvcpkg_python_test_import(MODULE \"${repo_name}\")\n")
    endif()
    
    #string(JSON new_manifest_json SET "${manifest_json}" "${ver_member}" "${upstream_version}")
    string(REPLACE "${version}" "${upstream_version}" new_manifest_json "${manifest_json}")
    file(WRITE "${port}/vcpkg.json" "${new_manifest_json}")
    string(REGEX REPLACE "SHA512( +)([a-zA-Z0-9]+)" "SHA512\\1${new_sha}" new_portfle_contents "${portfile_contents}")
    file(WRITE "${port}/portfile.cmake" "${new_portfle_contents}${extra}")
endmacro()

if(DEFINED ENV{VCPKG_DOWNLOADS})
  string(REPLACE "\\" "/" downloads "$ENV{VCPKG_DOWNLOADS}/")
endif()

if(NOT DEFINED PORT_GLOB)
  #set(PORT_GLOB "py-h11")
  set(PORT_GLOB "py-*")
endif()

#py-rpds; py-hatch py-hatchling

# py-packaging-wheel

set(exclude_ports "py-colorama;py-certifi;py-meson;py-pip;py-ply;py-psutil;py-pyproject-hooks;py-pyqt-builder;py-pyyaml;py-regex;py-setuptools;py-sip;py-sniffio")

file(GLOB ports_and_files LIST_DIRECTORIES true ${PORT_GLOB})
file(GLOB files LIST_DIRECTORIES false ${PORT_GLOB})
set(ports ${ports_and_files})
list(REMOVE_ITEM ports ${files} ${exclude_ports})

list(LENGTH ports n_ports_found)

find_program(pwsh_path pwsh)

message(STATUS "Found ${n_ports_found} ports with glob '${PORT_GLOB}' for updating!")
message(STATUS "*** Start updating")
foreach(port IN LISTS ports)
  block()
    cmake_path(GET port FILENAME port_name)
    set(update FALSE)
    message(STATUS "*** Reading manifest of ${port_name}")
    file(READ "${port}/vcpkg.json" manifest_json)
    string(REGEX MATCH "version(-(string|semver|date))?" ver_member "${manifest_json}")
    string(JSON version GET "${manifest_json}" "${ver_member}")
    message(STATUS "Found version from manifest: ${version}")
    file(READ "${port}/portfile.cmake" portfile_contents)
    
    set(add_python_test_import OFF)
    if(NOT portfile_contents MATCHES "vcpkg_python_test_import" AND port_name MATCHES "^py-")
      set(add_python_test_import ON)
    endif()
    
    if(portfile_contents MATCHES "vcpkg_from_pythonhosted")
      get_new_version_from_pypi()
    elseif(portfile_contents MATCHES "vcpkg_from_github")
      get_new_version_from_github()
    endif()
    message(STATUS "*** Finished updating of ${port_name}")
    set(update_able ${update_able} PARENT_SCOPE)
    set(not_update_able ${not_update_able} PARENT_SCOPE)
    set(up_to_date ${up_to_date} PARENT_SCOPE)
  endblock()
endforeach()

message("The following ports can be updated: ${update_able}\n\n")
message("The following ports can not be updated: ${not_update_able}\n\n")
message("The following ports are up to date: ${up_to_date}")

