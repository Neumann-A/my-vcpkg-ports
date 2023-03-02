vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libeigen/eigen
    REF 2b513ca2a00100a891219ba6472960d18b49afba
    SHA512 40a7e534c61e877e14dbbc76b0fa493fb167be60e208b8a59d00d08237c80c8164c415422afdabf4f513adc0f7c44f0e76a9311c44289e55146c17c8a8990a23
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

vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/eigen3/src/Core/util/MKL_support.h" "#ifdef EIGEN_USE_MKL_ALL" "#if 1")

file(GLOB INCLUDES "${CURRENT_PACKAGES_DIR}/include/eigen3/*")
file(COPY ${INCLUDES} DESTINATION "${CURRENT_PACKAGES_DIR}/include")

file(INSTALL "${SOURCE_PATH}/COPYING.README" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
