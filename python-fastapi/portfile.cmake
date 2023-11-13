vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO tiangolo/fastapi
    REF ${VERSION}
    SHA512 bed93b84709c64e4f6d170faeade91643a9186962ff5d34bb659fb303ea439c4f52f5e9f1e15f4ca0dd56a5e753ccdaa9bf5372deeb7dbd26ae84f59c393e58a
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
