vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO arogozhnikov/einops
    REF v${VERSION}
    SHA512 0805f5b11b97925090f92cde3f0b4e36c6109300658e15c0c4271a5ae30dfcd85fe18f4faca1acee2eaadab07cac05e81ae3b88c6a7b8970bfd297b539725d67
    HEAD_REF master
)


vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "einops")
