vcpkg_download_distfile(ARCHIVE
    URLS "https://netcologne.dl.sourceforge.net/project/omniorb/omniORB/omniORB-4.3.0/omniORB-4.3.0.tar.bz2"
    FILENAME "omniORB-${VERSION}.tar.bz2"
    SHA512 b081c1acbea3c7bee619a288fec209a0705b7d436f8e5fd4743675046356ef271a8c75882334fcbde4ff77d15f54d2da55f6cfcd117b01e42919d04fd29bfe2f
)
vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
    PATCHES wip.patch
            wip2.patch
            wip3.patch
)

#vcpkg_find_acquire_program(PYTHON3)
#cmake_path(GET PYTHON3 PARENT_PATH PYTHON3_DIR)
vcpkg_add_to_path("${CURRENT_HOST_INSTALLED_DIR}/tools/python3")
set(ENV{PYTHONPATH} "${CURRENT_HOST_INSTALLED_DIR}/tools/python3/Lib")

vcpkg_find_acquire_program(FLEX)
cmake_path(GET FLEX PARENT_PATH FLEX_DIR)
vcpkg_add_to_path("${FLEX_DIR}")

vcpkg_find_acquire_program(BISON)
cmake_path(GET BISON PARENT_PATH BISON_DIR)
vcpkg_add_to_path("${BISON_DIR}")

if(VCPKG_TARGET_IS_WINDOWS)
  string(APPEND VCPKG_LINKER_FLAGS " -v -fuse-ld=lld-link")
endif()

if(VCPKG_TARGET_IS_WINDOWS)
    z_vcpkg_get_cmake_vars(cmake_vars_file)
    include("${cmake_vars_file}")
endif()

vcpkg_configure_make(
  SOURCE_PATH "${SOURCE_PATH}"
  #AUTOCONFIG
  #NO_WRAPPERS
  COPY_SOURCE
  SKIP_CONFIGURE
  OPTIONS
)

vcpkg_build_make(
  MAKEFILE "GNUMakefile"
  SUBPATH "src"
  BUILD_TARGET "export"
  ADD_BIN_TO_PATH
)

vcpkg_fixup_pkgconfig()
#vcpkg_from_sourceforge(
#    OUT_SOURCE_PATH SOURCE_PATH
#    REPO omniorb/omniORB
#    REF ${VERSION}
#    SHA512 0
#    FILENAME "omniORB-${VERSION}.tar.bz2"
    #[DISABLE_SSL]
    #[NO_REMOVE_ONE_LEVEL]
    #[PATCHES <patch1.patch> <patch2.patch>...]
#)


# file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")

# vcpkg_cmake_configure(
    # SOURCE_PATH "${SOURCE_PATH}"
# )

# vcpkg_cmake_install()

# file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING.LIB")
