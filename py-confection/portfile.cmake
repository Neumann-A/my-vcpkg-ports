vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/confection
    REF v${VERSION}
    SHA512 abb9155ed29e4f92d9128ba74c7dc63153416e397ef7f1b6f6dd6cfb00fc8649f2ebe35deff29c4fe86708daa8d8582d25f7846ff195aaba5afd6fbb5f8e91f6
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "confection")
