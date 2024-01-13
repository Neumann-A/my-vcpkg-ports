vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/huggingface_hub
    REF v${VERSION}
    SHA512 50fe8ed10f31912481353202158b9ff245a33656c69accbc9a46d5953b5b76cf20ccdfa3c2ca89a6ebad54a5513f52fc7d75381a0f55187d174161d2e0a03707
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
