vcpkg_rust_install()

vcpkg_add_to_path("${CURRENT_HOST_INSTALLED_DIR}/tools/python3/Scripts")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/safetensors
    REF v${VERSION}
    SHA512 278469d7bc8a4285519cf8020891d0f0e107d8124ad2c24686ca8a19ef2f210c49d9483c502bd5aa5d73940a775ac3eb5e3b90f62825dd7845c351bbdc8c82c3
    HEAD_REF master
)

set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib")

file(COPY "${SOURCE_PATH}/README.md" DESTINATION "${SOURCE_PATH}/safetensors" ) # Error in the build scripts ?

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}/bindings/python")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "safetensors")
