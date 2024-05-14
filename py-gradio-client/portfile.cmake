string(REGEX REPLACE "^py-" "" package "${PORT}")
vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    ${package}
    VERSION         ${VERSION}
    FILENAME        gradio_client
    SHA512          350711e9a51a4edd36ded181215a60430c76f3749bd941b1972525637f563e0ef799476cd7601533dad01c663a97f895b8e510b8914f57d3dc761e28d73b3f33
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

# vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt") # Will get installed by py-gradio
file(WRITE "${CURRENT_PACKAGES_DIR}/share/py-gradio-client/copyright" "Apache-2.0 - see ../py-gradio/copyright")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

string(REGEX REPLACE "-" "_" test_package "${package}")
vcpkg_python_test_import(MODULE "${test_package}")