vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pypa/hatch
    REF hatch-v${VERSION}
    SHA512 8be25b9eecf7ff1e9ce750d8414cf8735cfec850e4cda8ac155e2b8becd1c647f1bc35bb5104c06dfb0b8c13b30964948b43725805b497d7e805b62f797a90d3
    HEAD_REF master
)


vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "hatch")
