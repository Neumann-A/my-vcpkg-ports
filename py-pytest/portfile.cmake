vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pytest-dev/pytest
    REF ${VERSION}
    SHA512 78abeac781c5ca1167ac4a22a6c3b586a8335c870151cbedac71afdc51f62bf109011d2d0f66d29cef7bf6d93a2de8aba0816d037d485e0396581d3a725df7cf
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "pytest")
