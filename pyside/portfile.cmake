vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO qtproject/pyside-pyside-setup
    REF v${VERSION}
    SHA512 5ec1fca08b450d734beaf61d32e125f717cfaddcff5942c4ea01a68d355019814e5940b1bd569615b3036673b80e5138dda63b723fb9214ceb54be571d2cd998
    HEAD_REF master
    PATCHES 
      fix_build.patch
      fixes.patch
)

set(ENV{LLVM_INSTALL_DIR} "${CURRENT_HOST_INSTALLED_DIR}/tools/llvm")
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
      "-DPYTHON_EXECUTABLE=${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python${VCPKG_HOST_EXECUTABLE_SUFFIX}"
      #-DSHIBOKEN_BUILD_TOOLS=OFF
      -DBUILD_TESTS=OFF
      -DNO_QT_TOOLS=yes
      #-DPYTHON_LIMITED_API=OFF
      #-DSHIBOKEN_PYTHON_LIMITED_API=OFF
      -DFORCE_LIMITED_API=OFF # Theoretically the default could be ON and OFF could be a feature 
      -DNUMPY_INCLUDE_DIR="${CURRENT_INSTALLED_DIR}/tools/python3/Lib/site-packages/numpy/core/include"
)


vcpkg_cmake_install(ADD_BIN_TO_PATH)
vcpkg_cmake_config_fixup(PACKAGE_NAME Shiboken6Tools CONFIG_PATH lib/cmake/Shiboken6Tools DO_NOT_DELETE_PARENT_CONFIG_PATH)
vcpkg_cmake_config_fixup(PACKAGE_NAME Shiboken6 CONFIG_PATH lib/cmake/Shiboken6 DO_NOT_DELETE_PARENT_CONFIG_PATH)
vcpkg_cmake_config_fixup(PACKAGE_NAME PySide6 CONFIG_PATH lib/cmake/PySide6 DO_NOT_DELETE_PARENT_CONFIG_PATH)
vcpkg_cmake_config_fixup(PACKAGE_NAME PySide6Qml CONFIG_PATH lib/cmake/PySide6Qml DO_NOT_DELETE_PARENT_CONFIG_PATH)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib/cmake")
if(NOT VCPKG_BUILD_TYPE)
  file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib/cmake")
endif()

set(abi cp311-win_amd64) # abi3 if limited


vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/Shiboken6/Shiboken6Config.${abi}.cmake" "/Lib/site-packages/" "/${PYTHON3_SITE}/")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/PySide6/PySide6Config.${abi}.cmake" "/Lib/site-packages/" "/${PYTHON3_SITE}/")


vcpkg_fixup_pkgconfig()
#uic rcc qmltyperegistrar qmlimportscanner lrelease lupdate qmllint qmlformat

vcpkg_copy_tools(TOOL_NAMES shiboken6 AUTO_CLEAN)

set(py_scripts
      shiboken_tool.py
      pyside_tool.py
      metaobjectdump.py
      project.py
      qml.py
      qtpy2cpp.py
      deploy.py
      deploy_lib
      project
      qtpy2cpp_lib
      android_deploy.py
)
foreach(script IN LISTS py_scripts)
  file(RENAME "${CURRENT_PACKAGES_DIR}/bin/${script}" "${CURRENT_PACKAGES_DIR}/tools/${PORT}/${script}")
  if(NOT VCPKG_BUILD_TYPE)
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin/${script}")
  endif()
endforeach()

file(GLOB lics "${SOURCE_PATH}/LICENSES/*")
vcpkg_install_copyright(FILE_LIST ${lics})

vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/lib/site-packages/PySide6/__init__.py" "${CURRENT_BUILDTREES_DIR}" "do-not-use-and-force-false")

file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/")
file(RENAME "${CURRENT_PACKAGES_DIR}/lib/site-packages" "${CURRENT_PACKAGES_DIR}/${PYTHON3_SITE}")

#TODO: Need to add "os.add_dll_directory(os.path.dirname(__file__)+'/../../../bin')" to "vcpkg\installed\triplet\lib\site-packages\shiboken6\__init__.py" before "from shiboken6.Shiboken import *"


