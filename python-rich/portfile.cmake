vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Textualize/rich
    REF v${VERSION}
    SHA512 c5c432bd73b0c28d9585bce2e122d6b9da0a0744ea7824b4682948f11e153dfc615f5ed94d9531ced422298d352371fba5f25ddf16ca7a1d669f799ab361d984
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
