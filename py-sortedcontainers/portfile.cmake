vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO grantjenks/python-sortedcontainers
    REF v${VERSION}
    SHA512 1c56daea5d491dbeea9c677677a79ef5c4805325ea3d5da97005cd3b269003a99459550a793dfe65820f152c774371472ba471a7daf61c9d97b36744bafb013b
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
