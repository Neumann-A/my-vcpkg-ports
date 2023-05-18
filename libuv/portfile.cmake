vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libuv/libuv
    REF 6f94701467cf62c42034fc8535b69c224659ae3b # 2023-05-16 v1.x
    SHA512 6843de75a510ef8c19f20be27aceb09f77ae9d7829f3c7f065183cf09a613ada73a372d9d4e3bbed89b6348c0a5df4397ac845a890f90a0ccb77425b95a119c4
    HEAD_REF v1.x
    PATCHES #fix-build-type.patch
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

