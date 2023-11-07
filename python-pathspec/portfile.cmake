vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cpburnz/python-pathspec
    REF v${VERSION}
    SHA512 66e320c8e3c5705b084d3a8554e34baefe1d2d53a27d375393c9d06d7d83ae0d2f101da6ac8765ae3ec96d8fb37382fbf02af2ef9dbbc961885c2ecfb44847f8
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
