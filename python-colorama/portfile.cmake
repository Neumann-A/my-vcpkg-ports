vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO tartley/colorama
    REF ${VERSION}
    SHA512 0
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
