vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO psf/requests
    REF v${VERSION}
    SHA512 43f536bdb2360fcceb24ef98e995ffa66cdefc2c502629f17a5722445bfa9ad8489201958c846c2aaef37e427f95a4d56e321a91095c69754680abfd83b39150
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
