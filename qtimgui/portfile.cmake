vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO seanchas116/qtimgui
    REF 027a548c22b06147fbbe2efa15e6e166f9d202ff
    SHA512 822418b78a38886c4c0d41061cc0e820ee4fecf0d0fc1d6d30dd501761ff1ab33277b23311ea3138a4581a07f15fad49a512d4192ae5742798196e3c3ed5ccee
    HEAD_REF master
    PATCHES fix_cmake.patch
            fix_install.patch
            fix_build.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS -DQT_MAJOR_VERSION=6
)

vcpkg_cmake_install()

vcpkg_copy_pdbs()
set(configfile 
[[
find_dependency(Qt6 COMPONENTS Gui Widgets)
find_dependency(imgui)
include("${CMAKE_CURRENT_LIST_DIR}/qtimgui.cmake")
]])
file(WRITE "${CURRENT_PACKAGES_DIR}/share/${PORT}/qtimgui-config.cmake" "${configfile}")
vcpkg_cmake_config_fixup()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)