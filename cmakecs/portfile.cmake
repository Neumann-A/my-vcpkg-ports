set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Neumann-A/CMakeCommonSetup
    REF 62a79a840db443b9e9ca0daeb05fb3b5d6ba7e8e 
    SHA512 2a2c435dd92ede5ff2bb0d54a0ae1fb7b74b0425bc063bc641d19a6447289322ade16839155591e0a933ac38c295b0bc152e418770b862bacb94357a8132763b
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
