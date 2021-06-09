#set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

#set(_VCPKG_DOWNLOAD_TOOL ARIA2)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    #GITHUB_HOST  ssh://git@github.com:
    AUTHORIZATION_TOKEN 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
    REPO Neumann-A/MyCEL
    REF f22863750418ad3c67a02a63ac95d14a1148bce5 
    SHA512 a32a9802e176e113e229e74997890bc8f9bd0d5e8f5579a1f12fc5fbb5550eacec9faf89be9736a3249a26b9ad04d1f9f8862c7948a2ed1013842f5e9ddeb74e
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        #--trace-expand
        -DCMAKE_MESSAGE_LOG_LEVEL=TRACE
)
vcpkg_install_cmake()

vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
 file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE.md" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
