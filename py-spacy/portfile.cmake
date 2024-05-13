vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/spaCy
    REF v${VERSION}
    SHA512 64bd1af0788a13d299d142ef6902a922c89fee3325b4f0023a1b2649b07e55141e0ea95695bb9f83a4820cc0d4e000d43304e294a0a2943688659cd567f49165
    HEAD_REF main
    PATCHES
        cython3-fixes.patch
        fix-build.patch
)

vcpkg_python_build_and_install_wheel(USE_BUILD SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "spacy")
