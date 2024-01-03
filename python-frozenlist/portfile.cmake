vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO aio-libs/frozenlist
    REF v${VERSION}
    SHA512 937f7684df3879596903b5ce2d9a38590383a7c319e3079bbd8fdcbea169c692d9feabac0a7e0646d334ec517a86f7d943e0b0107fd925203de1cc8029b252ba
    HEAD_REF master
)
set(ENV{FROZENLIST_NO_EXTENSIONS} 0)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
