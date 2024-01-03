vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/peft
    REF v${VERSION}
    SHA512 b5b591ddab09220db31a79b828119feece0fe563e083423420b36c4df66e1cd97e25af07dfd3a16b7f0ec7a2c0e550b4c3e4f0a74ae6bbb92e88f98a9fa1e98e
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
