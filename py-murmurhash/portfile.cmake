vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/murmurhash # TODO Devendor murmurhash?
    REF v${VERSION}
    SHA512 89741de10f265e89025d19375be1482619f0aba1c0122460a390481fb4a709bb29f623ee35870c1caaf33524d3646237017c37fb13050ae7824609a331f52a65
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "murmurhash")
