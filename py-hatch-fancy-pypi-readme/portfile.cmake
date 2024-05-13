vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO hynek/hatch-fancy-pypi-readme
    REF ${VERSION}
    SHA512 fc659ae9a3646e4d013827d82cc75545d2b6b7ea0fa72491b51acf63f264fd764ec0bf99e894244be6fe402eaf0fc458bc95f565822387dda528dbd0347e1202
    HEAD_REF main
    PATCHES
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "hatch_fancy_pypi_readme")
