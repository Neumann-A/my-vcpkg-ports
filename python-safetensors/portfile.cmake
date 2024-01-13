vcpkg_rust_install()

vcpkg_add_to_path("${CURRENT_HOST_INSTALLED_DIR}/tools/python3/Scripts")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/safetensors
    REF v${VERSION}
    SHA512 f2170184050cb040444f8357f5a49c4c574a56de8f67ab4cc3cde6dee844ea953a146106202800dbc655523996674fdfb80676a7de240356c56ecc849197f747
    HEAD_REF master
)

set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib")

file(COPY "${SOURCE_PATH}/README.md" DESTINATION "${SOURCE_PATH}/safetensors" ) # Error in the build scripts ?

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}/bindings/python")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
