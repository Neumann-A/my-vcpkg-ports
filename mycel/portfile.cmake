#set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

#set(_VCPKG_DOWNLOAD_TOOL ARIA2)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    #GITHUB_HOST  ssh://git@github.com:
    AUTHORIZATION_TOKEN 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
    REPO Neumann-A/MyCEL
    REF 62976a2f446b053c38b29770f3a4c0687adebc6f 
    SHA512 5eeeb8b1c77c0bd8318debe74177880d18444344e12013120644bb6bf199bc88ce499f608a3a615f9f82e1f75e9bb3719240e75cbd162119b22bb240e77d3d88
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        "-DCMakeJSON_INCLUDE_FILE=${CURRENT_INSTALLED_DIR}/share/CMakeJSON/CMakeJSON.cmake"
        -DCMAKE_MESSAGE_LOG_LEVEL=TRACE
)
vcpkg_install_cmake()

vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
 file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE.md" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
