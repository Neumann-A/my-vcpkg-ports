vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO kjd/idna
    REF v${VERSION}
    SHA512 0fc174ef91061e87cf31b7bc2ff7d1cb12167ece10f030fc3820bf27555e9fa498221161e3a0c272635013f4c771fc0e3855f8d968e0146fb5d93f81699f6bce
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
