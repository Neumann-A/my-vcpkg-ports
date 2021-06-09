set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Neumann-A/CMakeJSON
    REF df8a876141ebc6686cb2bc437140b1afe4ec6ec3
    SHA512 c9ec26af124f819583f3d999cb2c0fd0b71e7a1093f0e78804409182494696d35c87af3e51f7006773418a903f8b37c476ff0130a66ee66fdaf16846096bf636
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