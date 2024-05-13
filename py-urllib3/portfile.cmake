vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO urllib3/urllib3
    REF ${VERSION}
    SHA512 86713f54fe2a4c6c6ecfddfa939611526f81282162851d44e00d4b7ed21c3265b11a3ff506d685ddb88c0998f392809b7ffd08775608e309dd290fc30ab5d741
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "urllib3")
