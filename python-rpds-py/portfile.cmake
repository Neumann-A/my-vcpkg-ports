vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO crate-py/rpds
    REF v${VERSION}
    SHA512 0195353a563e0ba2473125be2b710684522cc304981814f3e15dde927bb1f8e58877495ea5cc7fdcc39cc59345accde03d9feffa645cd2e44c32fc0888d83c74
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
