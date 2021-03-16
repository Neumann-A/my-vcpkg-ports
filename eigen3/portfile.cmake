vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libeigen/eigen
    REF b8d1857f0d87475016b5c16a6a235efa1fd5e9b5
    SHA512 c47d73f8e1d08653175cbc9b6fb1651565ba0c6f7a04d1b5a85db35b104aee1c213722a1660f9ff6b12b7d32e8d347ec93352d0571fc82eeeeea462567d7c79a
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
