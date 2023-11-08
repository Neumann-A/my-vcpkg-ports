vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/huggingface_hub
    REF v${VERSION}
    SHA512 827932c36e6af7faba12fb6efad1586a37e4de6bfcf5c47c7ff5634e7d90fbe574eaac2657254e79dc3c743d6fd9d92f62559ec2ada9918e4358c6117710ba5d
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
