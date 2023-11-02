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
    #[NO_REMOVE_ONE_LEVEL]
    #[SKIP_PATCH_CHECK]
    #[PATCHES <patch>...]
    #[SOURCE_BASE <base>]
    #[BASE_DIRECTORY <relative-path> | WORKING_DIRECTORY <absolute-path>]
)

#vcpkg_from_bitbucket(
#    OUT_SOURCE_PATH src_path
#    REPO ICL/MAGMA
#    REF "v${VERSION}"
#    SHA512 b4d20901c21a7d60b2cf74592f4ae34c555ca8ffca29c1331c5d891ab2ee2cfcde739b78fd9319816b41317ca47b8b5dcfd1032a1502d718a75ebd185f091420
#    HEAD_REF master
#)

#if(CMAKE_HOST_WIN32)
#  vcpkg_acquire_msys(msys_root PACKAGES bash make)
#  set(bash_cmd "${msys_root}/usr/bin/bash.exe")
#  set(make_cmd "${msys_root}/usr/bin/make.exe")
#else()
#  set(make_cmd make)
#endif()

#set(ENV{GPU_TARGET} Pascal Volta Turing Ampere)

#vcpkg_find_acquire_program(PYTHON3)

#execute_process(
#  COMMAND ${PYTHON3} "${src_path}/tools/codegen.py"
#  WORKING_DIRECTORY "${src_path}"
#)

#file(WRITE "${src_path}/make.inc" "GPU_TARGET = Volta\nFORT = true\n")

#vcpkg_add_to_path("${msys_root}/usr/bin")

#execute_process(
#  COMMAND ${make_cmd} -d --trace -f ${src_path}/Makefile generate
#  WORKING_DIRECTORY "${src_path}"
#)

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

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/docs/license.rst")
