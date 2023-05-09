vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO vtjnash/libwhich
    REF 99a0ea12689e41164456dba03e93bc40924de880
    SHA512 b90fc075f7d8a37dd7e3c9701323bd728fd7e2d27e453f930cf91acd05f00086b946bb689b08a4851798a478334ded952036344f375d76620d181e8f91c5b84f
    HEAD_REF master
    PATCHES fix-msvc.patch
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")
vcpkg_cmake_install()
vcpkg_copy_tools(TOOL_NAMES libwhich AUTO_CLEAN)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)