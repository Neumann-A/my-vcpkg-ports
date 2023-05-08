vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO FreeCAD/FreeCAD
    REF 0e64e76514b66262af636cb533e9a01445b98880
    SHA512 a578cce21bf257f859b59826758eb9e9d39f1206b4fdde85fc961674a09c9bb9ba1f3ffea8d7bdd44ae378b5b55eb5b3ed13da8fd69dc22ed0bbcc85bef06047
    HEAD_REF master
    PATCHES
)

vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/Qt6/bin")
set(ENV{PYTHONPATH} "${CURRENT_INSTALLED_DIR}/Lib/site-packages")
#x_vcpkg_get_python_packages(PYTHON_VERSION "3" OUT_PYTHON_VAR "PYTHON3" PACKAGES pyside6 shiboken6 pivy)

string(APPEND VCPKG_C_FLAGS " -DHAVE_SHIBOKEN6 -DHAVE_PYSIDE6")
string(APPEND VCPKG_CXX_FLAGS " -DHAVE_SHIBOKEN6 -DHAVE_PYSIDE6")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
      -DFREECAD_LIBPACK_USE=OFF
      -DBUILD_GUI=ON
      -DFREECAD_USE_PCL=ON
      -DBUILD_FLAT_MESH=ON
      -DFREECAD_USE_SHIBOKEN=OFF
      -DPython_EXECUTABLE=${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python${VCPKG_HOST_EXECUTABLE_SUFFIX}
      -DBUILD_TECHDRAW=OFF # Requires xmlpattern
      -DFREECAD_QT_VERSION=6
      -DBUILD_TEST=OFF
      "-DFREECAD_USE_EXTERNAL_SMESH=ON"
      "-DFREECAD_USE_EXTERNAL_KDL=ON"
#      "-DPYTHON3_EXECUTABLE=${PYTHON3}"
      --trace-expand
      -DFREECAD_USE_SHIBOKEN=ON
      -DFREECAD_USE_PYSIDE=ON
)

vcpkg_cmake_install()

#E:\all\vcpkg\installed\x64-win-llvm-release\Lib\site-packages\shiboken6/../../../bin