vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python-jsonschema/referencing
    REF v${VERSION}
    SHA512 b00990a33539a12b07176b9a033e0adbd04f10cb9e39c771e8f35eccb78873785869d2ee95a182decdc83e67d552e2a5b353fd10ff357543ab46b3b4d90482bc
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "referencing")
