if(VCPKG_TARGET_IS_WINDOWS)
    vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO google/XNNPACK
    REF fcbf55af6cf28a4627bcd1f703ab7ad843f0f3a2 # 2022-12-22
    SHA512 8063e27686f7b71cfba05b0c004c46db4506638689ffb112f013b3886de58653b60ca5487978c3f96275c17bb1136883ca4c93ddb2241a2c31925a950cb51759
    HEAD_REF master
    PATCHES
        fix-build.patch
        #use-packages.patch
        #use-c-cpp-11.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DXNNPACK_USE_SYSTEM_LIBS=ON
        -DXNNPACK_ENABLE_ASSEMBLY=ON
        -DXNNPACK_ENABLE_MEMOPT=ON
        -DXNNPACK_ENABLE_SPARSE=ON
        -DXNNPACK_BUILD_TESTS=OFF
        -DXNNPACK_BUILD_BENCHMARKS=OFF
)
vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_cmake_config_fixup()

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include"
                    "${CURRENT_PACKAGES_DIR}/debug/bin"
                    "${CURRENT_PACKAGES_DIR}/debug/share"
)
