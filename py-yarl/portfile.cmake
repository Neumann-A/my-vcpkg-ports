vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO aio-libs/yarl
    REF v${VERSION}
    SHA512 e31a36539166034f3b231e1f9fc47b7d0d1aea0424b6054e1858eefa9f290350ee8b1c74bb90a120d6b9f3c13fe7b675d6e0676272b3222b788d479ae9fd3ff5
    HEAD_REF master
)
set(ENV{YARL_NO_EXTENSIONS} 0)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "yarl")
