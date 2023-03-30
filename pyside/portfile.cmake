vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO qtproject/pyside-pyside-setup
    REF 392559ed8c4d6a733a72af9c1311b8cb2ff3e633
    SHA512 4d6b9aa76cf9e199fc3209f5a44befcf7ae084fcaca1b9632393e3230a487375aadf42125be62960c3e5ecf027e952d50473f4fbd0ef7f0d664e513e8df159cd
    HEAD_REF master
    PATCHES fix_build.patch
)

set(ENV{LLVM_INSTALL_DIR} "${CURRENT_HOST_INSTALLED_DIR}/tools/llvm")
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
      -DPYTHON_EXECUTABLE=${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python${VCPKG_HOST_EXECUTABLE_SUFFIX}
      #-DSHIBOKEN_BUILD_TOOLS=OFF
      -DBUILD_TESTS=OFF
      -DNO_QT_TOOLS=yes
)

vcpkg_cmake_install(ADD_BIN_TO_PATH)
vcpkg_cmake_config_fixup(PACKAGE_NAME Shiboken6Tools CONFIG_PATH lib/cmake/Shiboken6Tools DO_NOT_DELETE_PARENT_CONFIG_PATH)
vcpkg_cmake_config_fixup(PACKAGE_NAME Shiboken6 CONFIG_PATH lib/cmake/Shiboken6-6.4.3 DO_NOT_DELETE_PARENT_CONFIG_PATH)
vcpkg_cmake_config_fixup(PACKAGE_NAME PySide6 CONFIG_PATH lib/cmake/PySide6-6.4.3 DO_NOT_DELETE_PARENT_CONFIG_PATH)
vcpkg_cmake_config_fixup(PACKAGE_NAME PySide6Qml CONFIG_PATH lib/cmake/PySide6Qml-6.4.3 DO_NOT_DELETE_PARENT_CONFIG_PATH)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib/cmake")
if(NOT VCPKG_BUILD_TYPE)
  file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib/cmake")
endif()

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
      deploy
      project
      qtpy2cpp_lib
)
foreach(script IN LISTS py_scripts)
  file(RENAME "${CURRENT_PACKAGES_DIR}/bin/${script}" "${CURRENT_PACKAGES_DIR}/tools/${PORT}/${script}")
  if(NOT VCPKG_BUILD_TYPE)
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin/${script}")
  endif()
endforeach()

file(GLOB lics "${SOURCE_PATH}/LICENSES/*")
vcpkg_install_copyright(FILE_LIST ${lics})

vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/Lib/site-packages/PySide6/__init__.py" "${CURRENT_BUILDTREES_DIR}" "do-not-use-and-force-false")
