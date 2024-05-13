vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    pluggy
    VERSION         ${VERSION}
    SHA512          b2b6a80737c06e1507eb12513ed7f5ce508fd4a139c559a3a15d9f173f4455ef3847783efb91c32eca6e26cbe37b0336467d50c5db0563d8dbd17bd825cd7407
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
