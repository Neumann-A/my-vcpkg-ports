vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pypa/hatch
    REF hatch-v${VERSION}
    SHA512 d3af0ae15b31913b71137b256e61f39987dd7b535eb7540ba6d6e6d27b90252f53fab94741397b4d3b4c1efb99289097493a82ac6d5ded93d21e51af021e6373
    HEAD_REF master
)


vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "hatch")
