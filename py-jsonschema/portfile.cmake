vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python-jsonschema/jsonschema
    REF v${VERSION}
    SHA512 bdc3369b16feb37bf2067e88e275cac218e346adc2a9de7f2ad214545a1f8ec43064943e09f2a5ee86376e7059fb426fc90704b704c7b048835f6e75a6c434f1
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "jsonschema")
