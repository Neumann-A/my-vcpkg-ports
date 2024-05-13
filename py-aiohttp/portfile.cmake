vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO aio-libs/aiohttp
    REF v${VERSION}
    SHA512 c3b29dbeff0c0289ae12d1ceeb0ffb560a2b9bdfcffa39edf9e13b4e6dc89b43facc8ca3391e8661227ca84b3e423aef41719137354f748f898d05c6e2d71f6b
    HEAD_REF master
)

vcpkg_add_to_path("${CURRENT_HOST_INSTALLED_DIR}/tools/python3/Scripts")

set(ENV{AIOHTTP_NO_EXTENSIONS} 0)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "aiohttp")
