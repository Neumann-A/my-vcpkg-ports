vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO HypothesisWorks/hypothesis
    REF hypothesis-python-${VERSION}
    SHA512 5aec60a77e0f0bbeafba07da2dce6896ff66d6074367128694ffb2b86a4d7d225fc1d0f8d938b6dbe9652abc7f8a5bc5b891a7a0bd86cd8955ee8031ef2cba80
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}/hypothesis-python")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "hypothesis")
