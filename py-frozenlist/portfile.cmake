vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO aio-libs/frozenlist
    REF v${VERSION}
    SHA512 a82059fd7d16ec8e17cdf9d05eb128194fc3eed7c20ea4a3daf508a949e6c039fb5824794eac1ca768de11d883f55f46de45f5dcc5031f5cb31291b33df87023
    HEAD_REF master
)
set(ENV{FROZENLIST_NO_EXTENSIONS} 0)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "frozenlist")
