vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jupyter-xeus/xeus
    REF 5a74c4478aa2d4462a8a4591986489dac5f91c96
    SHA512 470e4c78698b21a798d5b0e905418f4fdc29dad0edf448560fc6c44abaaefc8052ca6067ab18e4b735f204394da237a370f4876db1aa41f857fbe6cd57b25699
    HEAD_REF main
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" XEUS_BUILD_SHARED_LIBS)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static"  XEUS_BUILD_STATIC_LIBS)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
      -DXEUS_BUILD_SHARED_LIBS=${XEUS_BUILD_SHARED_LIBS}
      -DXEUS_BUILD_STATIC_LIBS=${XEUS_BUILD_STATIC_LIBS}
      -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/xeus)
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share" "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

