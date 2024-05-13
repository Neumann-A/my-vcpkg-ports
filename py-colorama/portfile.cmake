vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO tartley/colorama
    REF ${VERSION}
    SHA512 2b269b190041398a1808b0b5147e47422b4451a1bc91841d0957572214ba8addd731c8932afdc60bfbba9833a0fe6c9c5c2ecb150613f13498f661799d625e4f
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "colorama")
