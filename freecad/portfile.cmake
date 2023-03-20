vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO FreeCAD/FreeCAD
    REF 0e64e76514b66262af636cb533e9a01445b98880
    SHA512 0
    HEAD_REF master
    PATCHES
)


vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
)

vcpkg_cmake_install()
