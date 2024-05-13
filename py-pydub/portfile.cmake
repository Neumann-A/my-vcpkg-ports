vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jiaaro/pydub
    REF v${VERSION}
    SHA512 8c3fb3714c4b0aed37ba7ab6727776bf4cd7568c1f5060cf43c30ede8da2ce4b498fb83326daa19ef44635250d552295407289c3945681e028eedde1b2b418e0
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "pydub")
