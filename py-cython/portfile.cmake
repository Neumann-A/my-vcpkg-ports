vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO  cython/cython
    REF ${VERSION}
    SHA512 97aa831cea96c1f3c51653c51fadb0aea8bdfdb076a2c898862637f52b826bcb9162d1b7aade3304c5650d0b894cb1083052f036365d79cd3d390e0486b33ac5
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

if(NOT VCPKG_TARGET_IS_WINDOWS)
  vcpkg_copy_tools(TOOL_NAMES cygdb cython cythonize DESTINATION "${CURRENT_PACKAGES_DIR}/tools/python3" AUTO_CLEAN)
endif()

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "cython")
