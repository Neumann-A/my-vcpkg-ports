vcpkg_rust_install()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PyO3/maturin
    REF v${VERSION}
    SHA512 71d222f9038359028b13c09a69f27b1c5e8cad8b75e79f09ef4dd97061d31d8d26e017aad90263b72b13a84da3819419df7c527dbd7e4bd14e8ac17e0ac985bd
    HEAD_REF main
    PATCHES
      fix-maturing.patch
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/license-apache" "${SOURCE_PATH}/license-mit")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
