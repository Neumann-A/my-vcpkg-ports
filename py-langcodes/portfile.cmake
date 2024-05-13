string(REGEX REPLACE "^py-" "" package "${PORT}")
vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    ${package}
    VERSION         ${VERSION}
    SHA512          f280f8b26417f8c18d81c699dc65758250360014d953fe2917a122ea4b724772247e54ea4ba747f4143155c2034cd2456a308d871cb2d9917247e7f00d93ff24
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

string(REGEX REPLACE "-" "_" test_package "${package}")
vcpkg_python_test_import(MODULE "${test_package}")