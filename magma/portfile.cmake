vcpkg_from_bitbucket(
    OUT_SOURCE_PATH src_path
    REPO ICL/MAGMA
    REF "v${VERSION}"
    SHA512 b4d20901c21a7d60b2cf74592f4ae34c555ca8ffca29c1331c5d891ab2ee2cfcde739b78fd9319816b41317ca47b8b5dcfd1032a1502d718a75ebd185f091420
    HEAD_REF master
)

if(CMAKE_HOST_WIN32)
  vcpkg_acquire_msys(msys_root PACKAGES bash make)
  set(bash_cmd "${msys_root}/usr/bin/bash.exe")
  set(make_cmd "${msys_root}/usr/bin/make.exe")
else()
  set(make_cmd make)
endif()

#set(ENV{GPU_TARGET} Pascal Volta Turing Ampere)

vcpkg_find_acquire_program(PYTHON3)

#execute_process(
#  COMMAND ${PYTHON3} "${src_path}/tools/codegen.py"
#  WORKING_DIRECTORY "${src_path}"
#)

file(WRITE "${src_path}/make.inc" "GPU_TARGET = Volta\nFORT = true\n")

vcpkg_add_to_path("${msys_root}/usr/bin")

execute_process(
  COMMAND ${make_cmd} -d --trace -f ${src_path}/Makefile generate
  WORKING_DIRECTORY "${src_path}"
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

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/docs/license.rst")
