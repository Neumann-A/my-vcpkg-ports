vcpkg_rust_install()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PyO3/maturin
    REF v${VERSION}
    SHA512 92cca4b398f9ecf767ed7da27599cc328570e5ef18b39c0f1104438f2977395a02737c8a5c62d994490e248000cceaffbeba11cbf94e9f8756538851af8e6884
    HEAD_REF main
    PATCHES
      fix-maturing.patch
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/license-apache" "${SOURCE_PATH}/license-mit")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "maturin")
