vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pydantic/pydantic-core
    REF v${VERSION}
    SHA512 57ac6c28c8ebc05d42158c21a9056e08bc6549b0b43b5de6d154c0f8791157287c305874c0df8d5a3495f6c1482b9c24e9b2bf3c690ff0808bc40be41de60e91
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
set(ENV{PYTHON_VERSION} 3.11)
vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
