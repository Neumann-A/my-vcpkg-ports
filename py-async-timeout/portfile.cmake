vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO aio-libs/async-timeout
    REF v${VERSION}
    SHA512 cb5913647e99783ab6ef07901808baa09d7221fc5f1c6e49e7a3e35bf8b627a866277c6503418a00913c1a8f841514b0878a9469719ed7623d9d199de8df9ae8
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "async_timeout")
