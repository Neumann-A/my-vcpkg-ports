vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rspeer/langcodes
    REF v${VERSION}
    SHA512 af0844d704fbde6aeee67b2254b4b1f5f10d0b7b7f33f401f77bb5008d41234778a183ebecb23997a1faaccc23c9d7663e2c69b350c6d10b32d9c562c9428c6f
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
