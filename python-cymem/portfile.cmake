vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/cymem
    REF v${VERSION}
    SHA512 1428270b67def1a5f4fe94b7958e57c201ac021c6ee40420fab222bb66d99c4dc77db7d794c90c3772f5a2e2a504347928591073e7fa2fd2fa31691899632b38
    HEAD_REF main
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
