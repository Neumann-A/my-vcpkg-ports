vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO repo-helper/hatch-requirements-txt
    REF v${VERSION}
    SHA512 8c143b767869b2ea4b593d913b59c5c1fd3e79e34178ff74769502d08255d9572d06c32aa8bb1f13b6be08c6a19c0d1a73c93f8d698fd48cd029570d877455bd
    HEAD_REF main
    PATCHES
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "hatch_requirements_txt")
