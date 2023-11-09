vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mrabarnett/mrab-regex
    REF 2023.10.3
    SHA512 cb663fdf8303862eb8592b74cec8f50513e4812df61967f3bc5009f19ebc62fa52944671c5a1b0b273a93afc70b9f4ba0fde82d30a93fb49df4be0bd7debe20a
    HEAD_REF main
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
