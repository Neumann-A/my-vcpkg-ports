vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO fsspec/filesystem_spec
    REF ${VERSION}
    SHA512 6f38950efcab76b5dd059700c2fd2a03d7b935a4698e8601c6feb2fcb80813adaee4bb9f4803c972e23a8cd3925fcf3c61942f061f7f6d5ef4e6313cdad59ade
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
