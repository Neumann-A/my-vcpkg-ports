set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO coin3d/pivy
    REF 7592a6dfbb4bd721073d607a6f017e3beec2b684
    SHA512 92b47f3b88c7deb046ae2c63a50e302513101faf227803dccede36a69cbe7033e67d3cb6be2c8cdcc275efa41f7d3952455053181f7e31272ef42b749083576f
    HEAD_REF master
    PATCHES fix-install-dest.diff
)

vcpkg_find_acquire_program(SWIG)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
      "-DSWIG_EXECUTABLE=${SWIG}"
      "-DPIVY_USE_QT6=ON"
)

vcpkg_cmake_install()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

