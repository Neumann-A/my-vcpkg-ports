vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/wasabi
    REF v${VERSION}
    SHA512 63b1e098dfe169986454711f76bb787a191b7888ac560f71ff6a1c64ab071d2b20b10b11cacab12c0f1b23162f50d3de702dc70b48fefe04b1013397fccfc010
    HEAD_REF main
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
