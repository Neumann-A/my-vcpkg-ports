vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cpburnz/python-pathspec
    REF v${VERSION}
    SHA512 ea43cfde362165bc2a7467fd3ecdd9c77385201e7405caeec4c5eadbb5fe80a9452f0b243269e868d1cc84446c18c98daa98fa1ce11e3ec8b72cb09906edce69
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "pathspec")
