vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rspeer/language_data
    REF v${VERSION}
    SHA512 ed40b0809da7441990141500c54dc1c9ed68bb13677b77b41da55cafdd044fee74245679374fe895117fdf401ab0d360c5a598ca25f4eb3a67af59c9a5a06c5e
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

#vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE") # MIT

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
