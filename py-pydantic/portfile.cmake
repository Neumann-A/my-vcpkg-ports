vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pydantic/pydantic
    REF v${VERSION}
    SHA512 015050bc768909dced19ee008e81cb6efd79c754618802d59d5b998ca20ce0446f2b0e63061709c6fb669d9c66664256b53a84481bcaad547fb41b3a669d4d52
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "pydantic")
