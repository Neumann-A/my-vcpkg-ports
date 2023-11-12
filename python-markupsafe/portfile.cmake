vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pallets/markupsafe
    REF ${VERSION}
    SHA512 481a28805547e17c06b1995e6c6bb9c985a571bef6a524b0d9c24294b9e55b17f19f0dd8feae9e374fb3279d3bb4b527c69a835923be52e6ed7f87a6b03eaa4b
    HEAD_REF main
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.rst")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
