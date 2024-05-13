vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Python-Markdown/markdown
    REF ${VERSION}
    SHA512 1e3e65df98892061117679d93dcb6ec204221a9cf2ce3c5e21a19c92cb919f5768806cf87a88c3dff1c9c773e9984b216675ef37dfe706c49338ae9fc6dc2544
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "markdown")
