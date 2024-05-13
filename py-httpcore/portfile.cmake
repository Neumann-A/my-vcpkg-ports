vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO encode/httpcore
    REF ${VERSION}
    SHA512 4b37f3874e65908598b906167d5b0840f66ffef95b65110d318d9e64df5fd23770a08ea44ea2f3cf6f9db50f20bb9fec99b40323b959675b37168414cf397bf8
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "httpcore")
