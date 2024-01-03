vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Ousret/charset_normalizer
    REF ${VERSION}
    SHA512 52df4ed731fecf2736ce89af3348bdfaec28e2c6bb4526a3e6cb52d9d90db33fb7fc339a91e9b77da1268a879f865a944ddf761de0ce700c156a3e70a9ca88b1
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
