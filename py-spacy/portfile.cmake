vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/spaCy
    REF v${VERSION}
    SHA512 8c7c303fcd8e8367a58a867439654aaef86ed70ba7b8f9e9a392357bd6caf79ca838a2ef72d36460a5c589e8d73f020e327e6327642254ced649390f5e503364
    HEAD_REF main
    PATCHES
        cython3-fixes.patch
        fix-build.patch
)

vcpkg_python_build_and_install_wheel(USE_BUILD SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "spacy")
