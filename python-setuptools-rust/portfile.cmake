vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PyO3/setuptools-rust
    REF v${VERSION}
    SHA512 153dea2d1a73cef6a171454844a61caab07f38ce0902b0b3972afe5051eddf33a1869b822bd9b7c6e288855e31c47ef2037e398a7aea66f0fb5b6ece3dec9f48
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
