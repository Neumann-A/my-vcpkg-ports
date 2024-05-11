vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/datasets
    REF ${VERSION}
    SHA512 9f88b00ce8fdc0430f8de9a1cb3bf6428174e89af5ee10c0ba7bf6de1aa0e0dd4f8542ad18b0c5e1dbc74a3a4d66c99d0fccb3b04f205789ff646a6e817e9d57
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
