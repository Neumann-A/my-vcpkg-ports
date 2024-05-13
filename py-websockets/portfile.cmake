vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python-websockets/websockets
    REF ${VERSION}
    SHA512 f17943d444ce275b709cf89453b2d2cce09f5af26f0460e226c2e24cfbb425c825963352e130dcd4201587606355375b525d8e5a02eccbffbb3985a108a3ed5e
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/${PYTHON3_SITE}/websockets/__init__.py" "\"StatusLike\": \"typing\"" "\"StatusLike\": \".typing\"" )

vcpkg_python_test_import(MODULE "websockets")
