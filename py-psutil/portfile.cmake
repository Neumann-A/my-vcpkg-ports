vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO giampaolo/psutil
    REF release-${VERSION}
    SHA512 9943adcf4cdb333c729765fef9e3cc7623ef90cfdf8c91fcb8093c45a6978efa9f749b1f1818dde99a772b89e9dd86c3d7cc5f8f1047bf8782d00a30d9284c7f
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "psutil")
