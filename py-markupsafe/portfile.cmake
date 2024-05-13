vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pallets/markupsafe
    REF ${VERSION}
    SHA512 cde91bce963272c5d60e6640351a2c76f7b7413add45105995d6998972b7b1fec3cb8b1520daee58bf99bd32732c1f6a70c4b6c914e2fe6b7fcf3872282cc30e
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.rst")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "markupsafe")
