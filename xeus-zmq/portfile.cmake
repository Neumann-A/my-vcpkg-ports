vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jupyter-xeus/xeus-zmq
    REF 8e0055035247c0c8c92d0c1830ceceefc5020c59
    SHA512 68484a660f84982e1081b42d3115371897e0af19642da082920f554a2804e869a73251ae65cf10c436f33c3be0f1311b1e640294e9942ee69c26357d7b30ab5b
    HEAD_REF main
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" XEUS_ZMQ_BUILD_SHARED_LIBS)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static"  XEUS_ZMQ_BUILD_STATIC_LIBS)
#TODO: Patches to fix mixed linkage.

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
      -DXEUS_ZMQ_BUILD_SHARED_LIBS=${XEUS_ZMQ_BUILD_SHARED_LIBS}
      -DXEUS_ZMQ_BUILD_STATIC_LIBS=${XEUS_ZMQ_BUILD_STATIC_LIBS}
      -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/xeus-zmq)
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share" "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

