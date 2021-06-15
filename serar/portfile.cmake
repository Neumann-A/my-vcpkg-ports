#set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

#set(_VCPKG_DOWNLOAD_TOOL ARIA2)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    #GITHUB_HOST  ssh://git@github.com:
    AUTHORIZATION_TOKEN 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
    REPO Neumann-A/SerAr
    REF 9fdd6de6cf3f17f559234a2032fd03a6bd05ea0a 
    SHA512  b27e5041b0e97dc6a56f0675e23bbbbfda498780cc2482c67f0c130c63c5d81d597ac8d8254ee691c585c5b55c9a398e7d8f2d10d727c3cbd49e424b2d79d36f
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
        "-DCMakeJSON_INCLUDE_FILE=${CURRENT_INSTALLED_DIR}/share/CMakeJSON/CMakeJSON.cmake"
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
