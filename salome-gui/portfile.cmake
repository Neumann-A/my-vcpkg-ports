vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY) # hardcoded set(BUILD_SHARED_LIBS TRUE)

vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL "https://git.salome-platform.org/gitpub/modules/gui.git"
    REF "9bb50954cc070ced6dabf894f3bc4e03b6c3d3f5"
    PATCHES
)

#string(COMPARE EQUAL "${VCPKG_TARGET_ARCHITECTURE}" "x64"  SALOME_USE_64BIT_IDS)

set(ENV{PYTHONPATH} "${CURRENT_INSTALLED_DIR}/Lib/site-packages")

vcpkg_find_acquire_program(SWIG)
cmake_path(GET SWIG PARENT_PATH SWIG_DIR)
vcpkg_add_to_path("${SWIG_DIR}")

vcpkg_add_to_path("${CURRENT_HOST_INSTALLED_DIR}/tools/Qt6/bin")

x_vcpkg_get_python_packages(PYTHON_VERSION "3" OUT_PYTHON_VAR "PYTHON3" PACKAGES sip PyQt6==6.4.2 )
set(SIP "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-venv/Scripts/sip-build${VCPKG_HOST_EXECUTABLE_SUFFIX}")

set(ENV{PYTHONPATH} "${CURRENT_HOST_INSTALLED_DIR}/tools/python3/Lib;${CURRENT_INSTALLED_DIR}/lib/python3.10/site-packages")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
      "-DCONFIGURATION_ROOT_DIR=${SALOME_CONFIGURATION_ROOT_DIR}"
      "-DKERNEL_ROOT_DIR:PATH=${CURRENT_INSTALLED_DIR}/share/salomekernel"
      "-DSALOME_INSTALL_PYTHON=tools/python3/Lib/site-packages/salome"
      "-DSALOME_INSTALL_PYTHON_SHARED=tools/python3/Lib/site-packages/salome/shared_modules"
      -DSALOME_BUILD_TESTS=OFF
      -DSALOME_BUILD_DOC=OFF
      -DPYTHON_EXECUTABLE=${PYTHON3}
      -DSIP_EXECUTABLE=${SIP}
      -DSIP_ROOT_DIR=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-venv/Scripts/
      -DSIP_PYTHONPATH=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-venv/Lib/site-packages
      -DPYQT6_ROOT_DIR=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-venv/Scripts/
      -DPYQT_PYTHONPATH=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-venv/Lib/site-packages
      -DPYQT_PYUIC_EXECUTABLE=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-venv/Scripts/pyuic6${VCPKG_HOST_EXECUTABLE_SUFFIX}
      -DBUILD_PYMODULE=FALSE
      #--trace-expand
)
# PYQT_PYUIC_EXECUTABLE PYQT_PYRCC_EXECUTABLE PYQT_SIPS_DIR PYQT_PYUIC_PATH PYQT_PYRCC_PATH

vcpkg_cmake_install()

file(GLOB dll_files "${CURRENT_PACKAGES_DIR}/lib/*.dll")
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/bin")
foreach(dll_file IN LISTS dll_files)
  string(REPLACE "/lib/" "/bin/" new_loc "${dll_file}")
  file(RENAME "${dll_file}" "${new_loc}")
endforeach()

if(NOT VCPKG_BUILD_TYPE)
  file(GLOB dll_files "${CURRENT_PACKAGES_DIR}/debug/lib/*.dll")
  file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/debug/bin")
  foreach(dll_file IN LISTS dll_files)
    string(REPLACE "/lib/" "/bin/" new_loc "${dll_file}")
    file(RENAME "${dll_file}" "${new_loc}")
  endforeach()
endif()

vcpkg_cmake_config_fixup(PACKAGE_NAME SalomeKERNEL)

if(VCPKG_TARGET_IS_WINDOWS)
  set(file "${CURRENT_PACKAGES_DIR}/share/salomekernel/SalomeKERNELTargets-release.cmake")
  file(READ "${file}" contents)
  string(REGEX REPLACE "/lib/([^.]+)\\.dll" "/bin/\\1.dll" contents "${contents}")
  file(WRITE "${file}" "${contents}")

  if(NOT VCPKG_BUILD_TYPE)
    set(file "${CURRENT_PACKAGES_DIR}/share/salomekernel/SalomeKERNELTargets-debug.cmake")
    file(READ "${file}" contents)
    string(REGEX REPLACE "/lib/([^.]+)\\.dll" "/bin/\\1.dll" contents "${contents}")
    file(WRITE "${file}" "${contents}")
  endif()
endif()
file(GLOB idl_pys "${CURRENT_PACKAGES_DIR}/bin/salome/*idl.py")
foreach(idl_py IN LISTS idl_pys)
  file(READ "${idl_py}" contents)
  string(REPLACE "r\"${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/idl" "os.path.realpath(os.path.dirname(__file__)) + \"/../../../../idl/salome" contents "${contents}")
  string(REPLACE "${CURRENT_BUILDTREES_DIR}" "" contents "${contents}")
  file(WRITE "${idl_py}" "${contents}")
endforeach()

# TODO remove NO_MODULE from Config.cmake

file(RENAME "${CURRENT_PACKAGES_DIR}/bin/salome" "${CURRENT_PACKAGES_DIR}/tools/salome/bin/salome")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
vcpkg_copy_tool_dependencies("${CURRENT_PACKAGES_DIR}/tools/salome/bin")