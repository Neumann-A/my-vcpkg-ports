vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pygments/pygments
    REF ${VERSION}
    SHA512 5adc114b97fc5fd7a2cb092375045f06824c0b4e86ae008680f855339dcfb6d6cc4f178e01832a6c389689b588bf0ef2c9898c15b76c50dc4b4759f55a8271d8
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "pygments")
