vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/spaCy
    REF v${VERSION}
    SHA512 64bd1af0788a13d299d142ef6902a922c89fee3325b4f0023a1b2649b07e55141e0ea95695bb9f83a4820cc0d4e000d43304e294a0a2943688659cd567f49165
    HEAD_REF main
    PATCHES
        cython3-fixes.patch
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -x)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
