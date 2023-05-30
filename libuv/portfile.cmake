vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libuv/libuv
    REF 00357f87328def30a32af82c841e5d1667a2a827 # 5047b344522c905480b84d8fa636aadd88791941 # master  6f94701467cf62c42034fc8535b69c224659ae3b # 2023-05-16 v1.x
    SHA512 aa50a9dfa1f40eee6ffe9d96b65212ca1ed2257591ff62e3b43c4bdc870f0cceded414b16a9e3df451425f24e465b24ce5202456518b1f5d0707732c04d521b7 # 510b0fbd6d3be4d83ee9197d9efe95de9d069c374560f6657d915e41b8c068e582de63d72a56904f32730d42429b4bc30c91fbe968f9bd0f744bb3872537760c # 6843de75a510ef8c19f20be27aceb09f77ae9d7829f3c7f065183cf09a613ada73a372d9d4e3bbed89b6348c0a5df4397ac845a890f90a0ccb77425b95a119c4
    HEAD_REF master
    PATCHES #fix-build-type.patch
            #julia.diff
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DLIBUV_BUILD_TESTS=OFF
        -DQEMU=OFF
        -DASAN=OFF
        -DTSAN=OFF
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/libuv)
vcpkg_fixup_pkgconfig()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/uv.h" "defined(USING_UV_SHARED)" "1")
else()
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/uv.h" "defined(USING_UV_SHARED)" "0")
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share" "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

