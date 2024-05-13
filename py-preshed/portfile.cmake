vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/preshed
    REF v${VERSION}
    SHA512 145eb9275df733984dd092e06d06ded57cbabcb229f0e3dd0357e61bd502d43dd5a70969bdb0c2239508b04bf7f37aa31afb195ab7c731e020c0a1c209fc03fd
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "preshed")
