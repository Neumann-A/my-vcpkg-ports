vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO uqfoundation/dill
    REF dill-${VERSION}
    SHA512 33ec55dc32c9ddf275ce6e502187949bbc7ecc6d24560e132a7bed23e93254b771d38e59c4b6313bbfc25313305c43c6cba2fe07763a93238e1ba66c4bbd8cd4
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
