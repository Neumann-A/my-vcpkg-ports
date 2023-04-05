vcpkg_download_distfile(ARCHIVE
    URLS "https://netcologne.dl.sourceforge.net/project/omniorb/omniORB/omniORB-4.3.0/omniORB-4.3.0.tar.bz2"
    FILENAME "omniORB-${VERSION}.tar.bz2"
    SHA512 b081c1acbea3c7bee619a288fec209a0705b7d436f8e5fd4743675046356ef271a8c75882334fcbde4ff77d15f54d2da55f6cfcd117b01e42919d04fd29bfe2f
)
vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
    PATCHES wip.patch
            fix_dependency.patch
            def_gen_fix.patch
)

vcpkg_add_to_path("${CURRENT_HOST_INSTALLED_DIR}/tools/python3") # port ask python distutils for info.
set(ENV{PYTHONPATH} "${CURRENT_HOST_INSTALLED_DIR}/tools/python3/Lib")

vcpkg_find_acquire_program(FLEX)
cmake_path(GET FLEX PARENT_PATH FLEX_DIR)
vcpkg_add_to_path("${FLEX_DIR}")

vcpkg_find_acquire_program(BISON)
cmake_path(GET BISON PARENT_PATH BISON_DIR)
vcpkg_add_to_path("${BISON_DIR}")

#string(APPEND VCPKG_C_FLAGS_DEBUG " -D_DEBUG") # for python to autolink the correct lib
#string(APPEND VCPKG_CXX_FLAGS_DEBUG " -D_DEBUG")

if(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
  set(z_vcpkg_org_linkage "${VCPKG_LIBRARY_LINKAGE}") 
  # convoluted build system; shared builds requires 
  # static library to create def file for symbol export
  # tools seem to only dynamically link on windows due to make rules!
  set(VCPKG_LIBRARY_LINKAGE dynamic)
  string(APPEND VCPKG_LINKER_FLAGS " -v -fuse-ld=lld-link")
  z_vcpkg_get_cmake_vars(cmake_vars_file)
  include("${cmake_vars_file}")
  if(VCPKG_BUILD_TYPE)
    string(APPEND build_info "NoDebugBuild=1\n")
  endif()
  string(APPEND build_info "replace-with-per-config-text\n")
  set(progs C_COMPILER CXX_COMPILER AR
            LINKER RANLIB OBJDUMP MT
            STRIP NM DLLTOOL RC_COMPILER)
  list(TRANSFORM progs PREPEND "VCPKG_DETECTED_CMAKE_")
  foreach(prog IN LISTS progs)
      if(${prog})
          set(path "${${prog}}")
          unset(prog_found CACHE)
          get_filename_component(${prog} "${${prog}}" NAME)
          find_program(prog_found ${${prog}} PATHS ENV PATH NO_DEFAULT_PATH)
          if(NOT path STREQUAL prog_found)
              get_filename_component(path "${path}" DIRECTORY)
              vcpkg_add_to_path(PREPEND ${path})
          endif()
      endif()
  endforeach()
  configure_file("${CMAKE_CURRENT_LIST_DIR}/vcpkg.mk" "${SOURCE_PATH}/mk/platforms/vcpkg.mk" @ONLY NEWLINE_STYLE UNIX)
endif()

vcpkg_configure_make(
  SOURCE_PATH "${SOURCE_PATH}"
  AUTOCONFIG
  NO_WRAPPERS
  COPY_SOURCE
  OPTIONS
)

vcpkg_replace_string("${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel//mk/platforms/vcpkg.mk" "replace-with-per-config-text" "NoDebugBuild=1")
if(NOT VCPKG_BUILD_TYPE)
  vcpkg_replace_string("${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/mk/platforms/vcpkg.mk" "replace-with-per-config-text" "NoReleaseBuild=1\nBuildDebugBinary=1")
  vcpkg_replace_string("${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/src/tool/omniidl/cxx/dir.mk" "python$(subst .,,$(PYVERSION)).lib" "python$(subst .,,$(PYVERSION))_d.lib")
endif()

vcpkg_install_make(
  MAKEFILE "GNUMakefile"
  #SUBPATH "src"
  #BUILD_TARGET "export"
  #ADD_BIN_TO_PATH
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

# Restore old linkage info. 
if(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
   set(VCPKG_LIBRARY_LINKAGE ${z_vcpkg_org_linkage})
endif()
