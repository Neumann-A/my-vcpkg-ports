vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO altair-viz/altair
    REF v${VERSION}
    SHA512 f668902064fbe58537114716c85e6b63da993e5f0cacd75b4255ffe3ccf2db35998fdfe74fe1fa3e3c34cd4986e7fbe43e24f12798a090d2977a5539dba46e0b
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
