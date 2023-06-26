function(pypa_build_wheel)
    cmake_parse_arguments(
        PARSE_ARGV 0
        "arg"
        "ISOLATE"
        "SOURCE_PATH;OUTPUT_WHEEL"
        ""
    )

  set(build_ops "")

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

function(pypa_install_wheel)
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

  file(RENAME "${CURRENT_PACKAGES_DIR}${without_drive_letter_installed}/tools" "${CURRENT_PACKAGES_DIR}/tools")
  message(STATUS "*******fullStem:${fullStem}")
  #file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}${rootDir}")
endfunction()

function(pypa_build_and_install_wheel)
    cmake_parse_arguments(
        PARSE_ARGV 0
        "arg"
        "ISOLATE"
        "SOURCE_PATH"
        ""
    )

  set(opts "")
  if(arg_ISOLATE)
    set(opts ISOLATE)
  endif()

  #vcpkg_add_to_path("${PYTHON3_BASEDIR}/Scripts")
  pypa_build_wheel(${opts} SOURCE_PATH "${arg_SOURCE_PATH}" OUTPUT_WHEEL WHEEL)
  pypa_install_wheel(WHEEL "${WHEEL}")
endfunction()