vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Textualize/rich
    REF v${VERSION}
    SHA512 0c69101bc6c2a238a4c516812cda08299115b903b8282ee348b45b212a88fcbfbf69d11a3705a97bdb6192988ee3047804bb5b52b7950d860542cde8ce2d4bd2
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "rich")
