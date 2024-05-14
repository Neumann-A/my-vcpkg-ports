vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mideind/Tokenizer
    REF ${VERSION}
    SHA512 43c216dee5064bc1ed50d18476cffe7459a8585c793d12698da188935ebe993dbb189b179b9ad3b6bfb567c9a14aef3b18600f269d94100201ffbf313ce28f39
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "tokenizer")
