vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ijl/orjson
    REF ${VERSION}
    SHA512 a2d186f20e23e3ec60c0e0c833d38c6478626a7b3646620e038538d0cf20241ce2c46f28023f056ddad55dff8cbc5b41df4861b1caeec4dcffd6003dc00e9487
    HEAD_REF master
)

vcpkg_rust_install()
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3/Scripts") # for maturin
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3")
set(ENV{PYTHON} "${CURRENT_INSTALLED_DIR}/tools/python3/python.exe")
set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib")

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST 
"${SOURCE_PATH}/LICENSE-APACHE"
"${SOURCE_PATH}/LICENSE-MIT")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
