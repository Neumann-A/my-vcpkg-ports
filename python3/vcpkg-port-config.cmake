set(PYTHON3_VERSION "@VERSION@")
set(PYTHON3_VERSION_MAJOR "@PYTHON_VERSION_MAJOR@")
set(PYTHON3_VERSION_MINOR "@PYTHON_VERSION_MINOR@")
set(PYTHON3_INCLUDE "include/python${PYTHON3_VERSION_MAJOR}.${PYTHON3_VERSION_MINOR}")
set(PYTHON3_IS_DYNAMIC "@PYTHON_ALLOW_EXTENSIONS@")
set(site_base "")
if(VCPKG_TARGET_IS_WINDOWS)
  set(site_base "tools/python${PYTHON3_VERSION_MAJOR}/Lib")
else()
  set(site_base "lib/python${PYTHON3_VERSION_MAJOR}.${PYTHON3_VERSION_MINOR}")
endif()
set(PYTHON3_SITE "${site_base}/site-packages")

if(VCPKG_TARGET_IS_WINDOWS)
  set(VCPKG_PYTHON3_EXECUTABLE "${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python${VCPKG_HOST_EXECUTABLE_SUFFIX}")
else()
  set(VCPKG_PYTHON3_EXECUTABLE "${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python3${VCPKG_HOST_EXECUTABLE_SUFFIX}")
endif()

function(vcpkg_python_test_import)
  cmake_parse_arguments(
    PARSE_ARGV 0
    "arg"
    ""
    "MODULE"
    ""
  )

  if(VCPKG_CROSSCOMPILING OR VCPKG_CRT_LINKAGE STREQUAL "static")
    return()
  endif()

  message(STATUS "Testing import of python module '${arg_MODULE}' ...")

  set(PYTHONPATH_BACKUP "")
  
  set(ENV{PYTHONPATH} "${CURRENT_PACKAGES_DIR}/${PYTHON3_SITE}")

  set(DLL_DIR "${CURRENT_INSTALLED_DIR}/bin")
  configure_file("${CMAKE_CURRENT_FUNCTION_LIST_DIR}/import_test.py.in" "${CURRENT_BUILDTREES_DIR}/import_test.py" @ONLY)

  vcpkg_execute_required_process(COMMAND "${VCPKG_PYTHON3_EXECUTABLE}" "${CURRENT_BUILDTREES_DIR}/import_test.py"
    LOGNAME "python-import-${arg_MODULE}-${TARGET_TRIPLET}"
    WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}"
  )
  message(STATUS "Import of '${arg_MODULE}' successful")
endfunction()