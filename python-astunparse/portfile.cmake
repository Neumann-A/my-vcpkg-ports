vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO simonpercivall/astunparse
    REF v${VERSION}
    SHA512 8f85d848c65d1728df767b1c2aee44aa4ce79a6810c348a5b3669b56f4bc5ce7f09414557be38d0a5103a77872d75083762bd2829d02ac8414df17221d30492b
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
