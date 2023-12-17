vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO FreeCAD/FreeCAD
    REF ${VERSION}
    SHA512 bd7e9029b24d49ac0955797bcdbea1fd0826bdf9ab246135366dfc35b427004f103acccfc66d008e3ab3928f99e04200e335908a03166545554e2d3e969ae0f5
    HEAD_REF master
    PATCHES 
      diff.patch
      freecad.patch
      fixes2.patch
)

vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/Qt6/bin")

string(APPEND VCPKG_C_FLAGS " -DHAVE_SHIBOKEN6 -DHAVE_PYSIDE6")
string(APPEND VCPKG_CXX_FLAGS " -DHAVE_SHIBOKEN6 -DHAVE_PYSIDE6")

vcpkg_find_acquire_program(SWIG)
cmake_path(GET SWIG PARENT_PATH SWIG_DIR)
vcpkg_add_to_path("${SWIG_DIR}")

file(REMOVE "${SOURCE_PATH}/cMake/FindEigen3.cmake")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
      -DFREECAD_LIBPACK_USE=OFF
      -DBUILD_GUI=ON
      -DFREECAD_USE_PCL=ON
      -DBUILD_FLAT_MESH=ON
      -DFREECAD_USE_MP_COMPILE_FLAG=OFF
      -DPython_EXECUTABLE=${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python${VCPKG_HOST_EXECUTABLE_SUFFIX}
      -DBUILD_TECHDRAW=ON
      -DFREECAD_QT_VERSION=6
      -DBUILD_TEST=OFF
      "-DFREECAD_USE_EXTERNAL_SMESH=ON"
      "-DFREECAD_USE_EXTERNAL_KDL=ON"
      -DFREECAD_USE_SHIBOKEN=ON
      -DFREECAD_USE_PYSIDE=ON
      -DFREECAD_USE_PYBIND11=ON
      "-DEIGEN3_INCLUDE_DIR=${CURRENT_INSTALLED_DIR}/include/Eigen3"
      -DEIGEN3_VERSION=3.4.90
      -DEIGEN3_FOUND=ON
      -DENABLE_DEVELOPER_TESTS=OFF
)

vcpkg_cmake_install()

vcpkg_copy_tools(TOOL_NAMES FreeCAD FreeCADCmd  DESTINATION "${CURRENT_PACKAGES_DIR}/tools/${PORT}/bin" AUTO_CLEAN)

file(COPY "${CURRENT_INSTALLED_DIR}/tools/Qt6/bin/qt.conf" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/${PORT}/bin")
file(COPY "${CURRENT_INSTALLED_DIR}/tools/Qt6/bin/QtWebEngineProcess${VCPKG_TARGET_EXECUTABLE_SUFFIX}" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/${PORT}/bin")
file(COPY "${CURRENT_INSTALLED_DIR}/tools/python3/Lib" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/${PORT}/bin")

file(COPY "${CURRENT_PACKAGES_DIR}/lib/" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/${PORT}/lib" FILES_MATCHING PATTERN "*.pyd")

file(RENAME "${CURRENT_PACKAGES_DIR}/Mod" "${CURRENT_PACKAGES_DIR}/tools/${PORT}/Mod")
file(RENAME "${CURRENT_PACKAGES_DIR}/Ext" "${CURRENT_PACKAGES_DIR}/tools/${PORT}/Ext")
file(RENAME "${CURRENT_PACKAGES_DIR}/doc" "${CURRENT_PACKAGES_DIR}/tools/${PORT}/doc")
file(RENAME "${CURRENT_PACKAGES_DIR}/data" "${CURRENT_PACKAGES_DIR}/tools/${PORT}/data")

file(TOUCH "${CURRENT_PACKAGES_DIR}\tools\freecad\data\Mod\Material\StandardMaterial\Tools\NotEmpty")

file(REMOVE "${CURRENT_PACKAGES_DIR}\tools\freecad\bin\Lib\site-packages\pybind11\share\pkgconfig\pybind11.pc")

set(py_file "${CURRENT_PACKAGES_DIR}\tools\freecad\Ext\freecad\__init__.py")
file(READ "${py_file}" contents)
string(REPLACE "\"${CURRENT_PACKAGES_DIR}" "os.path.dirname(__file__) + \"/../.. " contents "${contents}")
file(WRITE "${py_file}" "${contents}")

# TODO: 
#
# Set Env qputenv("QT3D_RENDERER", "opengl");
#         qputenv("QSG_RHI_BACKEND", "opengl");
#
