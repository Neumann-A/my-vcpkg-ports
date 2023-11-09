vcpkg_rust_install()

vcpkg_add_to_path("${CURRENT_HOST_INSTALLED_DIR}/tools/python3/Scripts")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/safetensors
    REF v${VERSION}
    SHA512 da38f184f2c0730a59b1d4ca490758b71cb5ed3e1e16741bbf4b7bfac35fa1a4f24e5acbc35f3b38f10e4c46d81554896fbd95accfd671ee066c9fcbd50551ab
    HEAD_REF master
)

set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib")

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}/bindings/python")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
