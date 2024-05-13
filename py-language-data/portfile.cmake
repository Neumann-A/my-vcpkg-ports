vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO georgkrause/language_data
    REF v${VERSION}
    SHA512 2db0ea41aafeb6977ba06db59513328591074447535822ea51397273507722ee02597f49d4cd05ff2e480a395bc5ba1e9859ef55599e39084e6473fa0a074a48
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE") # MIT

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "language_data")
