vcpkg_download_distfile(ARCHIVE
  URLS "https://files.salome-platform.org/Salome/other/med-${VERSION}.tar.gz"
  FILENAME "med-${VERSION}.tar.gz"
  SHA512 8917e7ecfe30e1259b0927c8e1c3d6efd86ed2386813f6d90217bd95589199478e587f0815031ab65cacf7901a30b77a6307414f9073caffe6e7f013e710d768
)

vcpkg_extract_source_archive(
  SOURCE_PATH
  ARCHIVE ${ARCHIVE}
  PATCHES 
    hdf5.patch
    hdf5-2.patch
)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static"  MEDFILE_BUILD_STATIC_LIBS)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic"  MEDFILE_BUILD_SHARED_LIBS)


vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
      -DMEDFILE_BUILD_SHARED_LIBS=${MEDFILE_BUILD_SHARED_LIBS}
      -DMEDFILE_BUILD_STATIC_LIBS=${MEDFILE_BUILD_STATIC_LIBS}
      -DMEDFILE_INSTALL_DOC=OFF
      -DMEDFILE_BUILD_TESTS=OFF
    )

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME MEDFile CONFIG_PATH cmake)
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
vcpkg_copy_tools(TOOL_NAMES mdump2 mdump3 mdump4 medconforme AUTO_CLEAN)
if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()
# Correct upstream uses autotools
# vcpkg_configure_make(
    # AUTOCONFIG
    # SOURCE_PATH "${SOURCE_PATH}"
    # OPTIONS
      # --disable-fortran
      # #--with-hdf5=${CURRENT_INSTALLED_DIR}
# )

# vcpkg_install_make()
