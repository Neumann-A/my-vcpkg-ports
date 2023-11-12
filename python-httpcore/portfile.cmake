vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO encode/httpcore
    REF ${VERSION}
    SHA512 6fc0c686b0b02b1e822550c18a7a90d2501f9d530598511877ee8cb09a0bdc4d56afe48cbb5fab5f8c1a12ea443055fe2a081b990fa4270f84db8197646b4979
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
