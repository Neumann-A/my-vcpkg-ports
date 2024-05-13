string(REGEX REPLACE "^py-" "" package "${PORT}")
vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    ${package}
    FILENAME        poetry_core
    VERSION         ${VERSION}
    SHA512          51812a673cd430511aa33fc84a646f0f73a3dfc334848f570f598ddefc83b1d29ed2061cc0109e59dd9f15ad4863920a165dfec86a27ecd6aa7fcecd425f9c7f
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "poetry.core")