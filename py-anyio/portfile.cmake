string(REGEX REPLACE "^py-" "" package "${PORT}")
vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    ${package}
    VERSION         ${VERSION}
    SHA512          26ff552a03b24b63c7c99cffcec61e97289eacba3ad2fc7a3c1dde8cfaffd9a8d621b867429901c12d7cef912d3807db134dbeb9c5ba619921160f6d5df4d02f
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

string(REGEX REPLACE "-" "_" test_package "${package}")
vcpkg_python_test_import(MODULE "${test_package}")