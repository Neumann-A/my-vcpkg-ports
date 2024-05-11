vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/transformers
    REF v${VERSION}
    SHA512 e2f07f49f7ad0141dbb1ad594e7e1e0ab91c0b199d7f63e8396f4d6b58dbcf8f9004b9e809ad641950a9616d7755f0cd21fa332f47cbb9606a346a0184baa7b5
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
