vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO uqfoundation/multiprocess
    REF ${VERSION}
    SHA512 b38d0337e1b90ed43c3c8877d7ce3c5729950fd8f1ad8cd4561ece12848eff7ca7d8769f7cef3508735e16c1c2d76d1b17439f275ca52f9c13117e9346e645fa
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "multiprocess")
