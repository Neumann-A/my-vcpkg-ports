vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO hynek/hatch-fancy-pypi-readme
    REF ${VERSION}
    SHA512 a26b8205877815292c7c65380f3fff43a3222ec5044556a29fb0b570f0822b548f8f4403cb6a800044671692806b257ecee5f9ec0f3efb597e9a5780a8885424
    HEAD_REF main
    PATCHES
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
