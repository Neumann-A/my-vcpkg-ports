 vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pydantic/pydantic-core
    REF v${VERSION}
    SHA512 082f693b875d89dc4ccaed1b97fd2211b4a414b3a1f54072a9a1130411a111da9ec1a4187883cc7c516265239ea50a48085862939bd68f0c46c1c8ce679f43b1
    HEAD_REF main
)
vcpkg_rust_install()
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3/Scripts") # for maturin
vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/python3")
set(ENV{PYTHON} "${CURRENT_INSTALLED_DIR}/tools/python3/python.exe")
set(ENV{LINK} "$ENV{LINK} /LIBPATH:${CURRENT_INSTALLED_DIR}/lib")
set(ENV{CARGO_PROFILE_RELEASE_BUILD_OVERRIDE_DEBUG} true)
set(ENV{RUST_BACKTRACE} full)
#set(PYO3_PYTHON "${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python3.11.exe" )
#set(PYTHON_SYS_EXECUTEABLE "${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python3.11.exe")
set(ENV{PYTHON_VERSION} "${PYTHON3_VERSION_MAJOR}.${PYTHON3_VERSION_MINOR}")
vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "pydantic_core")
