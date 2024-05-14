vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    pluggy
    VERSION         ${VERSION}
    SHA512          032d41e1f2bed56eff22463c4645516e9415ee253e0a3fe5ba83a8de5e21700baae1f6384c979d2c6f622e4216a2b745eec489bc04f52a576d423e771365cc7a
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
