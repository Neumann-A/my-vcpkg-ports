vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO googleapis/google-api-python-client
    REF v${VERSION}
    SHA512 db382cebe0863ad1448bda8e90c2ffa45f7f554e1d28e09eff3137072677893d8ed2ea63c547e0665d9deabd91a91133668d33ff9c073457cc7e43acd5a388d7
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
