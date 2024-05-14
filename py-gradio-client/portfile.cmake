string(REGEX REPLACE "^py-" "" package "${PORT}")
vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    ${package}
    VERSION         ${VERSION}
    FILENAME        gradio_client
    SHA512          ff5b2a58e1bd9f729e43cd5c35ba4beea49a42baefb8d95ece563fc4dfeda50037ac6cbe393e708248dfdfed030a2f1279bf52e288c630c0b09b72363eb389c1
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

# vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt") # Will get installed by py-gradio
file(WRITE "${CURRENT_PACKAGES_DIR}/share/py-gradio-client/copyright" "Apache-2.0 - see ../py-gradio/copyright")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

string(REGEX REPLACE "-" "_" test_package "${package}")
vcpkg_python_test_import(MODULE "${test_package}")