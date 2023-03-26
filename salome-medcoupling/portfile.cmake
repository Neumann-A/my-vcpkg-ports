vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL "https://git.salome-platform.org/gitpub/tools/medcoupling.git"
    REF "fe2e38d301902c626f644907e00e499552bb2fa5"
    PATCHES
)

vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH_CONFIG
    URL "https://git.salome-platform.org/gitpub/tools/configuration.git"
    REF "25f724f7a6c0000330a40c3851dcd8bc2493e1fa"
    PATCHES
)


string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static"  MEDCOUPLING_BUILD_STATIC)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
      "-DCONFIGURATION_ROOT_DIR=${SOURCE_PATH_CONFIG}"
      -DMEDCOUPLING_BUILD_TESTS=OFF
      -DMEDCOUPLING_BUILD_PY_TESTS=OFF
      -DMEDCOUPLING_BUILD_DOC=OFF
      -DMEDCOUPLING_BUILD_STATIC=${MEDCOUPLING_BUILD_STATIC}
      
)

vcpkg_cmake_install()
