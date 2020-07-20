set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Neumann-A/CMakeCommonSetup
    REF 6c636a7132ecfbe6860a00ea4dd6992dbc906b3a
    SHA512 a39e4f0bca3e51291cb8cff7f939fe2a0bc15238f87590b9f55a0c3213b151d7cd138e62b94d6165055eba6125543608d4c5c80bd82fbb6e2bda7f323295f16b
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    #OPTIONS
)
vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH share/${PORT})

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
