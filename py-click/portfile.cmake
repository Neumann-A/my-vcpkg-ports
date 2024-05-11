vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pallets/click
    REF ${VERSION}
    SHA512 a1cb115b90193d78f94ec2a6af563b089820517e6e0e4b71ea3d6c68304444d16db3597358c62e1757d9d05449996b7168a220eecde6ab4991367fdb6e74096f
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.rst")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
