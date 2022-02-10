#set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

#set(_VCPKG_DOWNLOAD_TOOL ARIA2)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Neumann-A/MyCEL
    REF b9edad9d90e7e4af530d53401f8d07c0bfe8faeb 
    SHA512  73b86eb507317fcef02938b75f98f3cf9881211d177a6e5fc83e357b7b86623ede153f9fc3668790d0cce79839dd5ca4a8d79ad1795d74c26fc6f452532e026e
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
