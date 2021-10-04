vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cantonios/eigen
    REF f0f1d7938b7083800ff75fe88e15092f08a4e67e
    SHA512 1b161c20732fdbbae0e2baf1bd2e685878094bff5bb02ca75bf7d07ef94838cfc4c18fb3afff600cf9f95a8dfd58423405653e4b26c1e442eff59c1e5c03e28f 
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_TESTING=OFF
        -DEIGEN_BUILD_PKGCONFIG=ON
    OPTIONS_RELEASE
        "-DCMAKEPACKAGE_INSTALL_DIR:PATH=share/eigen3"
        "-DPKGCONFIG_INSTALL_DIR:PATH=lib/pkgconfig"
    OPTIONS_DEBUG
        "-DCMAKEPACKAGE_INSTALL_DIR:PATH=debug/share/eigen3"
        "-DPKGCONFIG_INSTALL_DIR:PATH=lib/pkgconfig"
)
vcpkg_install_cmake()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/eigen3/Eigen3Targets.cmake"
    "set(_IMPORT_PREFIX " "get_filename_component(_IMPORT_PREFIX \"\${CMAKE_CURRENT_LIST_DIR}/../..\" ABSOLUTE) #"
)

vcpkg_fixup_pkgconfig()

file(GLOB INCLUDES "${CURRENT_PACKAGES_DIR}/include/eigen3/*")
file(COPY ${INCLUDES} DESTINATION "${CURRENT_PACKAGES_DIR}/include")

file(INSTALL "${SOURCE_PATH}/COPYING.README" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
