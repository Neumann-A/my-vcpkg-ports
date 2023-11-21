vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO aio-libs/aiohttp
    REF v${VERSION}
    SHA512 e0b603a9c168bf7613303f32523a145dd8f53c00e5f1549d14bd04ec31847a0ec8f0a9a4630c7a37930f8dda478257fd6f8c67e3c76054a56b6efd6c614b20cd
    HEAD_REF master
)

vcpkg_add_to_path("${CURRENT_HOST_INSTALLED_DIR}/tools/python3/Scripts")

set(ENV{AIOHTTP_NO_EXTENSIONS} 0)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
