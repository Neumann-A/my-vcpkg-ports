set(ENV{SETUPTOOLS_SCM_PRETEND_VERSION} "${VERSION}")

function(vcpkg_python_build_wheel)
    cmake_parse_arguments(
        PARSE_ARGV 0
        "arg"
        "ISOLATE"
        "SOURCE_PATH;OUTPUT_WHEEL"
        "OPTIONS"
    )

  set(build_ops "${arg_OPTIONS}")

  if(NOT arg_ISOLATE)
    list(APPEND build_ops "-n")
  endif()

  set(z_vcpkg_wheeldir "${CURRENT_PACKAGES_DIR}/wheels")

  file(MAKE_DIRECTORY "${z_vcpkg_wheeldir}")

  message(STATUS "Building python wheel!")
  vcpkg_execute_required_process(COMMAND "${PYTHON3}" -m build -w ${build_ops} -o "${z_vcpkg_wheeldir}" "${arg_SOURCE_PATH}"
    LOGNAME "python-build-${TARGET_TRIPLET}"
    WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}"
  )
  message(STATUS "Finished building python wheel!")

  file(GLOB WHEEL "${z_vcpkg_wheeldir}/*.whl")

  set(${arg_OUTPUT_WHEEL} "${WHEEL}" PARENT_SCOPE)
endfunction()

function(vcpkg_python_install_wheel)
    cmake_parse_arguments(
        PARSE_ARGV 0
        "arg"
        ""
        "WHEEL"
        ""
    )

  set(build_ops "")

  message(STATUS "Installing python wheel:'${arg_WHEEL}'")
  vcpkg_execute_required_process(COMMAND "${PYTHON3}" -m installer 
    --prefix "${CURRENT_INSTALLED_DIR}/tools/python3" 
    --destdir "${CURRENT_PACKAGES_DIR}" "${arg_WHEEL}"
    LOGNAME "python-installer-${TARGET_TRIPLET}"
    WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}"
  )
  message(STATUS "Finished installing python wheel!")

  cmake_path(GET CURRENT_INSTALLED_DIR ROOT_NAME rootName)
  cmake_path(GET CURRENT_INSTALLED_DIR ROOT_DIRECTORY rootDir)
  cmake_path(GET CURRENT_INSTALLED_DIR STEM fullStem)
  string(REPLACE "${rootName}/" "/" without_drive_letter_installed ${CURRENT_INSTALLED_DIR})

  string(REPLACE "/" ";" path_list "${without_drive_letter_installed}")
  list(GET path_list 1 path_to_delete)

  if(NOT EXISTS "${CURRENT_PACKAGES_DIR}/tools")
    file(RENAME "${CURRENT_PACKAGES_DIR}${without_drive_letter_installed}/tools" "${CURRENT_PACKAGES_DIR}/tools")
  else()
    file(COPY "${CURRENT_PACKAGES_DIR}${without_drive_letter_installed}/tools/" DESTINATION "${CURRENT_PACKAGES_DIR}/tools")
  endif()
  file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/${path_to_delete}")
endfunction()

function(vcpkg_python_build_and_install_wheel)
    cmake_parse_arguments(
        PARSE_ARGV 0
        "arg"
        "ISOLATE"
        "SOURCE_PATH"
        "OPTIONS"
    )

  set(ENV{SETUPTOOLS_SCM_PRETEND_VERSION} "${VERSION}")

  if("-x" IN_LIST arg_OPTIONS)
    message(WARNING "Python wheel will be ignoring dependencies")
  endif()

  set(opts "")
  if(arg_ISOLATE)
    set(opts ISOLATE)
  endif()

  vcpkg_python_build_wheel(${opts} SOURCE_PATH "${arg_SOURCE_PATH}" OUTPUT_WHEEL WHEEL OPTIONS ${arg_OPTIONS})
  vcpkg_python_install_wheel(WHEEL "${WHEEL}")
endfunction()