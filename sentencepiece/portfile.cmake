vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO google/sentencepiece
    REF "v${VERSION}"
    SHA512 31dc4dc3f2ff4a7effc1ed2d6ad219bcd5d28c0bac89fdeae0336f23e93f954c597313788529e692a0d694d5fa7c3c285a485dfb84a96921efc4b49bcd465358
    HEAD_REF master
    PATCHES
        fix-build.patch
        fix-python.patch
)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic"  SPM_ENABLE_SHARED)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DSPM_ENABLE_SHARED=${SPM_ENABLE_SHARED}
        -DSPM_USE_BUILTIN_PROTOBUF=OFF
        -DSPM_USE_EXTERNAL_ABSL=OFF # too painfull to solve correctly
)

vcpkg_cmake_install()
vcpkg_fixup_pkgconfig()

vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/lib/pkgconfig/sentencepiece.pc" "-lprotobuf-lite" "-llibprotobuf-lite")
if(NOT VCPKG_BUILD_TYPE)
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/sentencepiece.pc" "-lprotobuf-lite" "-llibprotobuf-lite")
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/bin")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

if("python" IN_LIST FEATURES)
    vcpkg_add_to_path("${CURRENT_HOST_INSTALLED_DIR}/tools/pkgconf")
    set(ENV{PKG_CONFIG} "${CURRENT_HOST_INSTALLED_DIR}/tools/pkgconf/pkgconf")
    set(ENV{PKG_CONFIG_PATH} "${CURRENT_INSTALLED_DIR}/lib/pkgconfig;${CURRENT_PACKAGES_DIR}/lib/pkgconfig")
    vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}/python")
endif()
