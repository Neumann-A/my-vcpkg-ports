#https://github.com/ROCm-Developer-Tools/HIP/blob/develop/docs/developer_guide/build.md

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_CLR
    REPO ROCm-Developer-Tools/clr
    REF "rocm-${VERSION}"
    SHA512 d79323481d82fc02c12a32cdcc0d14437d512af023e7737db0387b7eecb27fe6e4ae7c71d6adce57932a04bb24c880440d9dc10aeb5af11a4f2ca64d44330965
    HEAD_REF master
)
set(ENV{CLR_DIR} "${SOURCE_CLR}")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_HIP
    REPO ROCm-Developer-Tools/hip
    REF "rocm-${VERSION}"
    SHA512 68fa8753725b53c999d102d254c6b1dba53af4e00d6a48db93d10213cc02eec30b4a39c66e773d4f625dd9636cf8b0c5faa05b69fac27cf5a6b19dd3ddd2b905
    HEAD_REF master
)
set(ENV{HIP_DIR} "${SOURCE_HIP}")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_HIPCC
    REPO ROCm-Developer-Tools/HIPCC
    REF "rocm-${VERSION}"
    SHA512 2d232c8dd4a47de6e0cff9d37b4e63a26cb1809ef2ff3a119c15e992cae96ffc2f4d8c1ddffd8732dea3a3d589a93e177f424a6174f982908aa50904e265432a
    HEAD_REF master
)
set(ENV{HIPCC_DIR} "${SOURCE_HIPCC}")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_HIPCC}"
    OPTIONS
)
vcpkg_cmake_install()

vcpkg_copy_tools(TOOL_NAMES

    hipcc.bin hipconfig.bin

    AUTO_CLEAN
)

set(scripts
    hipcc hipconfig
    hipcc.bat hipconfig.bat
    hipcc.pl hipconfig.pl
    hipvars.pm
)

foreach(script IN LISTS scripts)
  file(RENAME "${CURRENT_PACKAGES_DIR}/bin/${script}" "${CURRENT_PACKAGES_DIR}/tools/${PORT}/${script}")
endforeach()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_CLR}"
    OPTIONS
      -DHIP_PLATFORM=amd
      -DHIP_COMMON_DIR=${SOURCE_HIP}
      #-DHIPCC_BIN_DIR=$HIPCC_DIR/build
      -DCLR_BUILD_HIP=ON 
      -DCLR_BUILD_OCL=OFF
      "-DHIPCC_BIN_DIR=${CURRENT_PACKAGES_DIR}/tools/rocm-hip/"
)
vcpkg_cmake_install()