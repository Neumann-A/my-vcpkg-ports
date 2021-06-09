#set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

set(_VCPKG_DOWNLOAD_TOOL ARIA2)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    #GITHUB_HOST  ssh://git@github.com:
    AUTHORIZATION_TOKEN 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
    REPO Neumann-A/SerAr
    REF 35686e3d7df938d8c6e04da018ac386c4e89e14e 
    SHA512  4a5ad4190447e6f8be1c23a8abe665d2b0cc4910d65388a07ebef4e05c7aba07710ac55a307ae6a834b3c53c44bdb969fcdfa53bb3dd3a01db1d7e8270d3e355
    HEAD_REF master
)


vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
    "hdf5"              SERAR_WITH_HDF5
    "matlab"            SERAR_WITH_MATLAB
    "qt"                SERAR_WITH_QTUI
    "json"              SERAR_WITH_JSON
    "program-options"   SERAR_WITH_PROGRAMOPTIONS
    "cereal"            SERAR_WITH_CEREAL
    "config"            SERAR_WITH_CONFIGFILE
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        #-DCMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT=OFF
        #-DSerAr_WITH_HDF5=OFF
        #-DMATLAB_FIND_DEBUG=ON
        ${FEATURE_OPTIONS}
)
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(NO_PREFIX_CORRECTION)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()


# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE.md" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
