vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ofek/hatch-vcs
    REF v${VERSION}
    SHA512 bf40cc371c8d8e120fce83e5986fc2bdc2087fa5a4ac4a407d32617e98205ded79dcb29a00c7638ba68dd5ce09f31e84b34176627a6a34dfb7708031f4c4519a
    HEAD_REF main
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
