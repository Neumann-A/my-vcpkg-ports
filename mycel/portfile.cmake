vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Neumann-A/MyCEL
    REF 919d80467a9542b832cddb27059fc39e6957f835 
    SHA512  f1249292af412fa44517bd72e829f0f519c70ba65396ccc7a634ba01936d0f13eea5e5721f1c1cedd5ec868b5c3c931d269a123b67d0d5aa9b5abc4c1ce63d5e
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        "-DCMakeJSON_INCLUDE_FILE=${CURRENT_INSTALLED_DIR}/share/CMakeJSON/CMakeJSON.cmake"
        -DCMAKE_MESSAGE_LOG_LEVEL=TRACE
)
vcpkg_cmake_install()

vcpkg_cmake_config_fixup()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE.md" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
