vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libeigen/eigen
    REF f04fd8b1686fdcaca35a5eb8d4b3b1ff50fc4636
    SHA512 5948b042d10ae6e147d93c73833227e557535cc01413b00242135bb1801312e90aafe0c8bbe3defc59408256d5b818b349db18eb30bd8318c40ba645d5af9da7 
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
