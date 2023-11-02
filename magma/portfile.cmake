vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(
    dist_file
    URLS https://icl.utk.edu/projectsfiles/magma/downloads/magma-2.7.2.tar.gz
    FILENAME magma-v${VERSION}
    SHA512 #de32950e1a05fec50663ce0b8f100c97bd2b96019670331c803077d35ecf182ad2bf7b793e27602cf280a895c4dbe4e9eaa2fc1bc4e22b6da00985acbcd5b1ec #
           7ab52ad09f452f7b997da573f74465d5bc8c83392f724747b131a7015b1445c457defdb59ae7a2fd4930e2cdc5bce3c7b99a069f04db1752a5df36ddc6e84987
)

vcpkg_extract_source_archive(
    src_path
    ARCHIVE "${dist_file}"
    PATCHES disable-openmp-msvc.patch
)

vcpkg_cmake_configure(
  SOURCE_PATH "${src_path}"
  OPTIONS
    -DMAGMA_ENABLE_CUDA=ON 
    -DMAGMA_ENABLE_HIP=OFF # HIP is backend and seems additive !
    -DUSE_FORTRAN=OFF
    
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup()

file(REMOVE_RECURSE
  "${CURRENT_INSTALLED_DIR}/debug/include"
  "${CURRENT_INSTALLED_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYRIGHT")
