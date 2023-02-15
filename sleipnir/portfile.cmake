#set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

#set(_VCPKG_DOWNLOAD_TOOL ARIA2)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO SleipnirGroup/Sleipnir
    REF a9632db7bde6c0e79b9547425adaa8ca45e949ac
    SHA512 06eb965699dd8d106ddd6f806d23b395112e82cd1c683f65c407d08e72a5e73428f98dda3bca80306a9b74a3cdff45edd5e9864d17770087e8a35fb89675024f
    HEAD_REF main
)

# vcpkg_check_features(
#     OUT_FEATURE_OPTIONS FEATURE_OPTIONS
#     FEATURES
#     "hdf5"              SERAR_WITH_HDF5
#     "matlab"            SERAR_WITH_MATLAB
#     "qt"                SERAR_WITH_QTUI
#     "json"              SERAR_WITH_JSON
#     "toml"              SERAR_WITH_TOML
#     "program-options"   SERAR_WITH_PROGRAMOPTIONS
#     "cereal"            SERAR_WITH_CEREAL
#     "config"            SERAR_WITH_CONFIGFILE
# )

string(APPEND VCPKG_C_FLAGS " -DEIGEN_USE_MKL_ALL")
string(APPEND VCPKG_CXX_FLAGS " -DEIGEN_USE_MKL_ALL")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        "-DFETCHCONTENT_TRY_FIND_PACKAGE_MODE=ALWAYS"
        "-DBUILD_TESTING=OFF"
        "-DBUILD_BECNHMARKING=OFF"
)
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/Sleipnir")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()

# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
