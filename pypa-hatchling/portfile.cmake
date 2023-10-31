vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pypa/hatch
    REF 33aa4d3dfd2e7046de24a5bf11613d98c0ca4c87
    SHA512 7bb760a58646771721365b5513a7ca8e9ee32e8e29fb2649b9ff89a09db08231789b6f1b288610f6b73b71aafa544ecbf5e504c298a734d58e29c45ee2831deb
    HEAD_REF master
)


pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}/backend")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
