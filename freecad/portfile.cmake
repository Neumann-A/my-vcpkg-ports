vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO FreeCAD/FreeCAD
    REF 0e64e76514b66262af636cb533e9a01445b98880
    SHA512 a578cce21bf257f859b59826758eb9e9d39f1206b4fdde85fc961674a09c9bb9ba1f3ffea8d7bdd44ae378b5b55eb5b3ed13da8fd69dc22ed0bbcc85bef06047
    HEAD_REF master
    PATCHES
)

vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/Qt6/bin")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
      -DFREECAD_LIBPACK_USE=OFF
      -DBUILD_GUI=ON
      -DFREECAD_USE_PCL=ON
      -DBUILD_FLAT_MESH=ON
)

vcpkg_cmake_install()
