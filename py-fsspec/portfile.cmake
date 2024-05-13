vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO fsspec/filesystem_spec
    REF ${VERSION}
    SHA512 456bfe4aa2394c7035d006e4c3f518c6ea813d098f874d00835b011985c09fb17016cdc8097f6e7bba1e0c2c1d6ad3d67fea78e59440a44f806c3ed93dad9361
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(USE_BUILD SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "fsspec")
