vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO crate-py/rpds
    REF v${VERSION}
    SHA512 cb563762c0e2263282d5e6afb408e4ec08091ecbdb79deee27597f90c0eb1bde66da83c54d81edf4d2c1bb4b98ffa1e07150eb181bb8e99b8aa1a97bd7e718c4
    HEAD_REF master
)
vcpkg_rust_install()
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3/Scripts") # for maturin
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3")
set(ENV{PYTHON} "${CURRENT_INSTALLED_DIR}/tools/python3/python.exe")
set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib")
vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "rpds")
