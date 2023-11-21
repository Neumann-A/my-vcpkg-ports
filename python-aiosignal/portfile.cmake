vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO aio-libs/aiosignal
    REF v${VERSION}
    SHA512 c03454d1b855bb3e84d3ce07fb32d08855b42d1ca7723fd67d3b2ef1bc66038a31974fabda7561c90e2beaf4cdd2c28cc0463e43eb5d5c127df0cd187ae3c2e2
    HEAD_REF master
)
pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
