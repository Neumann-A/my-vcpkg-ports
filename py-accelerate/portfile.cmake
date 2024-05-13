vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/accelerate
    REF v${VERSION}
    SHA512 fb52d8d9e60f7de0e335638dd722f84831ba82db9abfc5abe28f211edcd34d3896cb0c04706cef0b00f55d0902b9aa11557819c757a781b4e3dae5652c7d9618
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "accelerate")
