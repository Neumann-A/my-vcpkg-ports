#set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

#set(_VCPKG_DOWNLOAD_TOOL ARIA2)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    #GITHUB_HOST  ssh://git@github.com:
    AUTHORIZATION_TOKEN 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
    REPO Neumann-A/SerAr
    REF f0154d8eebe7fccfaa2d40d59cc7a800a2b6ec96
    SHA512  3e188de538ee1d8aec6960e595cd8975ca61579e6ed0699515eb2c365f6bf5ece98c78d2502fa2c9c715e42ee9f6249cb3c41bd5b37946a3191f452a19f449b7
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
