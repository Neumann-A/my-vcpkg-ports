vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO encode/httpx
    REF ${VERSION}
    SHA512 9db19cced6554effdb5fb0b442cbe05dc66cbfbdb23e8fbc19f43e1acc81028bca9e0fba5d2dae617b19be9f64baa0f02e727e92fef3f3f1288aa19ae07f35c6
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "httpx")
