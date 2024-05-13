vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO andrew-d/python-multipart
    REF ${VERSION}
    SHA512 6e41be080e079b1e9730e61d72b5b339fbb447bfb2b171a617c17025c5ad69924ca3c24f39e160f7b1cc495cea0999e72e6674e5631ce88a48240ecc229d0343
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "multipart")
