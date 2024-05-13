vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Tinche/aiofiles
    REF v${VERSION}
    SHA512 e88bf7901ca54bb57de901863a81f63584ab1a917e311ae5287e9710714a3213151ba3e95640b680a4a288a7e441e6b6e9105214a8a011a6df9e84bd3c701862
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "aiofiles")
