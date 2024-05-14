vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO HypothesisWorks/hypothesis
    REF hypothesis-python-${VERSION}
    SHA512 acb2b5f62e9f23eb379d61705f22330d9e81f7a23164bbdd196124fc3a67ba1265125597f840fa135f35af6f626229b3340b9557b2d69fc81f0b08c99d948e18
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}/hypothesis-python")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "hypothesis")
