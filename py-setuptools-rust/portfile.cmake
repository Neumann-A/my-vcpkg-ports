vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PyO3/setuptools-rust
    REF v${VERSION}
    SHA512 874bb632a2847cd5febeaa766765ee58432b1a0b96fddfe0fb779f9d7965b726a7c7836e3de6700d801aca1b00a64326ca3de63027069c4a047800bd5d64dfcc
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

vcpkg_python_test_import(MODULE "setuptools_rust")
