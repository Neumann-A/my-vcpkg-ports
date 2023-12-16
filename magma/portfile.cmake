vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(
    dist_file
    URLS https://icl.utk.edu/projectsfiles/magma/downloads/magma-2.7.2.tar.gz
    FILENAME magma-${VERSION}.tar.gz
    SHA512 7ab52ad09f452f7b997da573f74465d5bc8c83392f724747b131a7015b1445c457defdb59ae7a2fd4930e2cdc5bce3c7b99a069f04db1752a5df36ddc6e84987
    PATCHES
      fix-cuda.patch
)

vcpkg_extract_source_archive(
    src_path
    ARCHIVE "${dist_file}"
    PATCHES 
      disable-openmp-msvc.patch
      no-tests.patch
)

vcpkg_cmake_configure(
  SOURCE_PATH "${src_path}"
  OPTIONS
    #--trace-expand
    -DMAGMA_ENABLE_CUDA=ON 
    -DMAGMA_ENABLE_HIP=OFF # HIP is backend and seems additive !
    -DUSE_FORTRAN=OFF
    
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup()
vcpkg_fixup_pkgconfig()

file(READ "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/magma.pc" contents)
string(REGEX REPLACE "Cflags: [^\n]+" "" contents "${contents}")
file(WRITE "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/magma.pc" "${contents}")

if(NOT VCPKG_BUILD_TYPE)
  file(READ "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/magma.pc" contents)
  string(REGEX REPLACE "Cflags: [^\n]+" "" contents "${contents}")
  file(WRITE "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/magma.pc" "${contents}")
endif()

file(REMOVE_RECURSE
  "${CURRENT_INSTALLED_DIR}/debug/include"
  "${CURRENT_INSTALLED_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${src_path}/COPYRIGHT")
