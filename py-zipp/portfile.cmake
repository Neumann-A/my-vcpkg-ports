string(REGEX REPLACE "^py-" "" package "${PORT}")
vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    ${package}
    VERSION         ${VERSION}
    SHA512          27f2a5a098c773ea878b751e5c1d4e6bb89a367cd676f0b4508f3c372e78e1522de6eb46a17c8ac22a09cc6b041e393db40d14d918c7abe44cc2158f886a8045
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

string(REGEX REPLACE "-" "_" test_package "${package}")
vcpkg_python_test_import(MODULE "${test_package}")
