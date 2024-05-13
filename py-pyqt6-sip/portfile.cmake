set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    PyQt6_sip
    VERSION         ${VERSION}
    SHA512          bd2fa70d64544d8104d3477cb650a0e6bcefa0008680afcf7d187ba3fb1117871c0237d3a7f047144c8a8a8eeb8da941a3b206f8ee0601cb2cc734243cdb9d46
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

vcpkg_python_test_import(MODULE "PyQt6.sip")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

