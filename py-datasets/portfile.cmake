vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/datasets
    REF ${VERSION}
    SHA512 6dab029dadfbe6346ce954425c1feba2c97c81ad2d18e3de49bd8147a42560d69712b730c9c64824974366bd30821bd94266caa1dc081d00206cfded66bbb95e
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "datasets")
