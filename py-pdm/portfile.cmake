vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pdm-project/pdm
    REF ${VERSION}
    SHA512 46b967038111d5e5aa19bfe27aefdfa4e82288f3f67a466f87dd8ae69d8d88723096c89514783c73cdc42d91ed80f3e399792bacd9be932d6925500b2405a012
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "pdm")
