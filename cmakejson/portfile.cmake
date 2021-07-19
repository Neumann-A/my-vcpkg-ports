set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Neumann-A/CMakeJSON
    REF 50a498f940e11b98392e13fc6231d73f65e410c5
    SHA512 52038e9a61079fcc88f30993bfbd1d46f44a10e45f989e8d6c505cc6aaed051b21ee010d7afced7ff76c537ec187fbddc73258eab671d57e2d373713710506cc
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