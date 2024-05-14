string(REGEX REPLACE "^py-" "" package "${PORT}")
vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    ${package}
    FILENAME        torch_grammar
    VERSION         ${VERSION}
    SHA512          f50db69a47c189cb70f0eb0bdf7b2dbddd244b04552165fce0384875a7246be72a4150b9f84cbef670559a911b50ee540b90aa1813a3c4396b978ab232b494f5
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

file(WRITE "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright" "MIT")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

string(REGEX REPLACE "-" "_" test_package "${package}")
vcpkg_python_test_import(MODULE "${test_package}")