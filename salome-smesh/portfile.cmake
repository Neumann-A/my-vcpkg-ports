vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL "https://git.salome-platform.org/gitpub/modules/smesh.git"
    REF "2653bcf37414d5a96c98ced7bb14b9b792422ca5"
    PATCHES
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static"  SMESH_BUILD_STATIC)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
      "-DCONFIGURATION_ROOT_DIR=${SALOME_CONFIGURATION_ROOT_DIR}"
      -DSMESH_BUILD_TESTS=OFF
      -DSMESH_BUILD_PY_TESTS=OFF
      -DSMESH_BUILD_DOC=OFF
      -DSMESH_BUILD_STATIC=${SMESH_BUILD_STATIC}
      
)

vcpkg_cmake_install()
