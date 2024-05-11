vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO encode/uvicorn
    REF ${VERSION}
    SHA512 98b58ce17a1f072f36923b1b616f818cbadd091256ce1281a5236268ba2378d212384d9c3390b5903edfda5c692a67935051379e31732df45422595a88c69232
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
