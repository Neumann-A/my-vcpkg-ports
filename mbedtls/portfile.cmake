vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Mbed-TLS/mbedtls
    REF v3.4.0
    SHA512 be24d2c926f94a7958c4340574e2c74a745120ccf20bcaeeda18b9c0e732fd1913f37c1f883b74ff772c24fbe8763c25c34e99a20a69e023c3d0d49aedd5f6b5
    HEAD_REF development
    PATCHES
        #enable-pthread.patch
        shared.patch
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        pthreads LINK_WITH_PTHREAD
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" USE_SHARED_MBEDTLS_LIBRARY)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" USE_STATIC_MBEDTLS_LIBRARY)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        ${FEATURE_OPTIONS}
        -DENABLE_TESTING=OFF
        -DENABLE_PROGRAMS=OFF
        -DMBEDTLS_FATAL_WARNINGS=FALSE
        -DUSE_SHARED_MBEDTLS_LIBRARY=${USE_SHARED_MBEDTLS_LIBRARY}
        -DUSE_STATIC_MBEDTLS_LIBRARY=${USE_STATIC_MBEDTLS_LIBRARY}
        -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME MbedTLS CONFIG_PATH "lib/cmake")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)



if (VCPKG_TARGET_IS_WINDOWS AND pthreads IN_LIST FEATURES)
    file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
endif ()

vcpkg_copy_pdbs()
