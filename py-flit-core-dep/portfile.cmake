vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pypa/flit
    REF ${VERSION}
    SHA512 1218756afcb79af1df0020548102ba29245a9fa998d332357a2a6a2b7b543dda835918f4811ba343e86e1f7c6b45a6dcafe26f8e905c1e49734141f7d4e9f4fc
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
