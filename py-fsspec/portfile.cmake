vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO fsspec/filesystem_spec
    REF ${VERSION}
    SHA512 637ca386d60dadd823a5689ae0d24955d5d4d54b9699fb5383e3fd433c9f557432462987a64ca89dbd3915f53cf778d2ef9a7338071931cc290bf933c656fce3
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(USE_BUILD SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "fsspec")
