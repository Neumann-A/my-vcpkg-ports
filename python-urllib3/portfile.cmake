vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO urllib3/urllib3
    REF ${VERSION}
    SHA512 3819d87a0b37859b7b6615170016fe2885ed818e289fc56ecd180b97eef4d1ad0c587b0250cc0d2eb73a3c21223febda95a5b6a5b4c27f88038da89d3e889eeb
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
