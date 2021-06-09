set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Neumann-A/CMakeCommonSetup
    REF bae056b5e9432b3574888e4e4a7db1e549ddc88b
    SHA512 6aab006cb8308b166416f4efb374b1ee45b04c577d11f046f7a10e6ac50595073ea01c23f43e20cc5526eb22ee4e922e15fa36d8c8e1a75e6f16fb5555d1cd8e
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
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
