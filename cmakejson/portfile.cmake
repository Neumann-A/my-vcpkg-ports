set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Neumann-A/CMakeJSON
    REF 0a4dac8188fc303bf0459b700e7e3df7c1fb44f8
    SHA512 4d0448a8c4400f56571f7466b4594f1944af7195c738b1d9f2097cae4270d83d42ba1fd56c867973221e8b37eeec8e823e690e3823ff09b9a0ed8ff3e54c7bf3
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