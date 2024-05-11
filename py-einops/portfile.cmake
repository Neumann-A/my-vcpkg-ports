vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO arogozhnikov/einops
    REF v${VERSION}
    SHA512 7a0e7ab38fcc7307e156a6e4964f9ebbdfd5de4c179240b8450cf4ed064bdab217f138caa4e6c21502a565340ec61210b6f7d2b90acd5e5b6c8fa31e42417135
    HEAD_REF master
)


vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
