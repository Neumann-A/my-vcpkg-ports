set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Neumann-A/CMakeJSON
    REF 47737f2f87b5071dcad7b28248583aa2453e0dd5
    SHA512 f1a92d97d0de8c6b11d635f9aaeb5fc76eb155c55496db7a5078cd8e753b8833e415d6036e1226d0c63a86a8d4c9b62ab019bf70d767ef907b83bbb816b67147
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