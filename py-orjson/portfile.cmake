vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ijl/orjson
    REF ${VERSION}
    SHA512 d6ae291b37ec2e0410d770be40f201f2a03c582130eea5a11fb159fa8db459551ccb74220644b391072bf070d8b7f076dfb9c0f6f8ccec1e3f578bb0653b47fc
    HEAD_REF master
)

vcpkg_rust_install()
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3/Scripts") # for maturin
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3")
set(ENV{PYTHON} "${CURRENT_INSTALLED_DIR}/tools/python3/python.exe")
set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib")

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST 
"${SOURCE_PATH}/LICENSE-APACHE"
"${SOURCE_PATH}/LICENSE-MIT")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "orjson")
