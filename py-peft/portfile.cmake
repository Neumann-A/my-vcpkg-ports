vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/peft
    REF v${VERSION}
    SHA512 a486bc612b2c24a76b72926aee49d866acbb5859e8dcf6375b0f97b62eeb55c7ebc70b28a3f2dfd3047ec519cf39e325ece17cb6d87bc5278211f7d1f1932f95
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "peft")
