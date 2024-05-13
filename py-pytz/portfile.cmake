string(REGEX REPLACE "^py-" "" package "${PORT}")
vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    ${package}
    VERSION         ${VERSION}
    SHA512          cc1e4c9b34c62791cea277a0ce188d975e62135cb15bccfb49dc1a9366c7697ead9c67956846699f18b90db4c66e6c5fe1a91a524d01ae821c0eaa613550ea74
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

string(REGEX REPLACE "-" "_" test_package "${package}")
vcpkg_python_test_import(MODULE "${test_package}")