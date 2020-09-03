set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Neumann-A/CMakeCommonSetup
    REF d0a2ed74f6437a308a74582ce3ee9d66fa26f447
    SHA512 6a144cdb8cfbeaf2a970453e7a572d615176b26bef2691a3df6bf4b92949f0f01605786baa1681bb137071723dd35cf549bd36939705395bcadc705dfe321d57
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DCMakeCS_ENABLE_GTest=OFF
)
vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH share/${PORT})

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
