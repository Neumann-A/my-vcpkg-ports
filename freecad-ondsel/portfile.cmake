vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Ondsel-Development/FreeCAD
    REF ${VERSION}
    SHA512 3f9b332c1d847d84df02dcf8e4db2eb086445185a81e86e52eb982a8e6bdda1a7ad2edb2a8b805225e59118bd53829cb529ad95bd91d4080e9e5263745f44fcd
    HEAD_REF master
    PATCHES 
      diff.patch
      freecad.patch
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
      -DFREECAD_USE_EXTERNAL_ONDSELSOLVER=ON
      -DFREECAD_LIBPACK_USE=OFF
      -DBUILD_GUI=ON
      -DFREECAD_USE_PCH=OFF
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
file(COPY "${CURRENT_INSTALLED_DIR}/${PYTHON3_SITE}/../" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/${PORT}/bin/Lib")
file(COPY "${CURRENT_INSTALLED_DIR}/tools/python3/DLLs" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/${PORT}/lib")



file(COPY "${CURRENT_PACKAGES_DIR}/lib/" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/${PORT}/lib" FILES_MATCHING PATTERN "*.pyd")

file(RENAME "${CURRENT_PACKAGES_DIR}/Mod" "${CURRENT_PACKAGES_DIR}/tools/${PORT}/Mod")
file(RENAME "${CURRENT_PACKAGES_DIR}/Ext" "${CURRENT_PACKAGES_DIR}/tools/${PORT}/Ext")
file(RENAME "${CURRENT_PACKAGES_DIR}/doc" "${CURRENT_PACKAGES_DIR}/tools/${PORT}/doc")
file(RENAME "${CURRENT_PACKAGES_DIR}/data" "${CURRENT_PACKAGES_DIR}/tools/${PORT}/data")

#file(TOUCH "${CURRENT_PACKAGES_DIR}/tools/${PORT}/data/Mod/Material/StandardMaterial/Tools/NotEmpty")

file(REMOVE "${CURRENT_PACKAGES_DIR}/tools/${PORT}/bin/Lib/site-packages/pybind11/share/pkgconfig/pybind11.pc")

#set(py_file "${CURRENT_PACKAGES_DIR}/tools/${PORT}/Ext/freecad/__init__.py")
#file(READ "${py_file}" contents)
#string(REPLACE "\"${CURRENT_PACKAGES_DIR}" "os.path.dirname(__file__) + \"/../.." contents "${contents}")
#file(WRITE "${py_file}" "${contents}")

# TODO: 
#
# Set Env qputenv("QT3D_RENDERER", "opengl");
#         qputenv("QSG_RHI_BACKEND", "opengl");
#

#copy python DLLS
#Absolute paths were found in the following files:
#  E:\all\vcpkg\packages\freecad-ondsel_x64-win-llvm-opt-rel\tools\freecad-ondsel\bin\Lib\site-packages\freecad\__init__.py