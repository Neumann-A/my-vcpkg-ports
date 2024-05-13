vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO googleapis/google-api-python-client
    REF v${VERSION}
    SHA512 30f5a31f760720c494e7cc93eacb73353efe5c3eea40d3e6a666834d2dc58bca8668d541a33063b8c5e4dca03211658a8fd8afe677346fceec35c09eb10023b2
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "googleapiclient")
