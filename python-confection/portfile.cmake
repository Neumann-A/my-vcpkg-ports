vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/confection
    REF v${VERSION}
    SHA512 db07295cfd8ae935610a82f6693c197763791fec88ac9b5875129edd6d8273e38e2c13cdde0109a240c67c214ebf795f33fef5a7f3237b81130b4ca608407aa0
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
