vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pytoolz/toolz
    REF ${VERSION}
    SHA512 dd00deca651e4c177e7b95153bb7666cae25676c8c0543ea47f1cea476b859064c221ccba1f3296172002c670e32fe8bdc8a18b38b8ce85713848d6f455f0e51
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(USE_BUILD SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "toolz")
