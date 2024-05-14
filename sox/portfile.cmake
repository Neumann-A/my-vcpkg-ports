vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_sourceforge(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sox
    FILENAME "sox/${VERSION}/sox-${VERSION}.tar.gz"
    SHA512 b5c6203f4f5577503a034fe5b3d6a033ee97fe4d171c533933e2b036118a43a14f97c9668433229708609ccf9ee16abdeca3fc7501aa0aafe06baacbba537eca
    PATCHES
      fix-build.patch
      fix-vorbis.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_fixup_pkgconfig()
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.LGPL" "${SOURCE_PATH}/LICENSE.GPL")

vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/lib/pkgconfig/sox.pc" "-lsox" "-llibsox -llibmp3lame -llpc10 -lgsm")
if(NOT VCPKG_BUILD_TYPE)
  vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/sox.pc" "-lsox" "-llibsox -llibmp3lame -llpc10 -lgsm")
endif()


file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/doc")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/doc")
