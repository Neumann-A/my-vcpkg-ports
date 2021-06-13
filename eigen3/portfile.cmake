vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libeigen/eigen
    REF fc87e2cbaa65e7e93a2c695ce5a9dc048a64a985
    SHA512 57f542667ff295d152c21298c80dfefb3b0c48ef29e2fbe4434300cbd63886e970956376e63b60f2561ad35c303da070e2464a9bac3380e2b1206c08cf24d613
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_TESTING=OFF
        -DEIGEN_BUILD_PKGCONFIG=ON
    OPTIONS_RELEASE
        -DCMAKEPACKAGE_INSTALL_DIR=share/eigen3
        -DPKGCONFIG_INSTALL_DIR=lib/pkgconfig
    OPTIONS_DEBUG
        -DCMAKEPACKAGE_INSTALL_DIR=debug/share/eigen3
        -DPKGCONFIG_INSTALL_DIR=lib/pkgconfig
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/debug/share)

vcpkg_replace_string(${CURRENT_PACKAGES_DIR}/share/eigen3/Eigen3Targets.cmake
    "set(_IMPORT_PREFIX " "get_filename_component(_IMPORT_PREFIX \"\${CMAKE_CURRENT_LIST_DIR}/../..\" ABSOLUTE) #"
)

vcpkg_fixup_pkgconfig()

file(GLOB INCLUDES ${CURRENT_PACKAGES_DIR}/include/eigen3/*)
file(COPY ${INCLUDES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)

file(INSTALL ${SOURCE_PATH}/COPYING.README DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
