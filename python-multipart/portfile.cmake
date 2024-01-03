vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO andrew-d/python-multipart
    REF ${VERSION}
    SHA512 fb996725266996aefb5284b4815ecd8d0005344359f29780f0c2817125f625f3910be14d7d937e975b3ca9fb27a2a483401ab342a0c861df0e1112d447b1f083
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
