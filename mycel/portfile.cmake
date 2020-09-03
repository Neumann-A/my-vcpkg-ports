#set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    #GITHUB_HOST  ssh://git@github.com:
    AUTHORIZATION_TOKEN ac08b9d9bf859498cbf0b66bd33512efa315a2fc
    REPO Neumann-A/MyCEL
    REF 245ffc41cdfb43a916e0aca85c84b73cbafaf23d 
    SHA512 5a77e8404cc61a81ebbbb9a2ac960f16cb201c34a613da30809d737103131ac2733511f46ef6c0885b2f3e9afd96cafae4b0f7c5db77fa3e18b0a42569d6baa4
    HEAD_REF dev
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        #-DCMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT=OFF
        -DCMAKE_MESSAGE_LOG_LEVEL=TRACE
)
vcpkg_install_cmake()

vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
