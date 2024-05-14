vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO DeflatedPickle/rpds
    REF 251a6785f362897db4be24d9974a366e343ca8b6
    SHA512 ff69d09afa00a5c820fcb6c3e40fd37aa29c1b9d2268db59833b2fcb7e6a5fe332cf7fc7cef74ae8c0871d64e723366c1abcc137c5bbd01b32bdcffa852c165f
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "rpds")
