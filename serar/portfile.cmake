#set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

#set(_VCPKG_DOWNLOAD_TOOL ARIA2)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    #GITHUB_HOST  ssh://git@github.com:
    AUTHORIZATION_TOKEN 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
    REPO Neumann-A/SerAr
    REF 760f8d5b1030682c74191688bf52ff522fc510d9 
    SHA512  43425783aaebd6ca3e36648ac3fac2017ab8a83f35f798171011742a97721db36fc84af618347474a8e8ff20903c8f31e3306bfb36a6169b0fcfeab35e3bc731
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
