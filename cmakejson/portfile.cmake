set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Neumann-A/CMakeJSON
    REF 5b9256ab9b127d123db8f29a6c472905244e65c1
    SHA512 daf5eb76cefbac455095174a5bc98cf604254490192b01b1c3038ca6bc526184be4d53360add443042850b79417edd3d4d3ac669fa2bbf9b7cd034b72d68f3a7
    HEAD_REF master
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
    "examples" BUILD_TESTING
    "examples" BUILD_EXAMPLES
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    PREFER_NINJA
    OPTIONS
        ${FEATURE_OPTIONS}
)
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH share/${PORT})

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
file(INSTALL "${SOURCE_PATH}/FindCMakeJSON.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")