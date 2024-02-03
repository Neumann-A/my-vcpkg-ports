vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL "https://git.salome-platform.org/gitpub/plugins/netgenplugin.git"
    REF "3af617de2150a1f2aace89182033d20e6fc0b237"
    PATCHES fix_build.patch fix-occ78.patch
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static"  SMESH_BUILD_STATIC)

vcpkg_find_acquire_program(SWIG)
cmake_path(GET SWIG PARENT_PATH SWIG_DIR)
vcpkg_add_to_path("${SWIG_DIR}")

set(ENV{PYTHONPATH} "${CURRENT_HOST_INSTALLED_DIR}/tools/python3/Lib;${CURRENT_INSTALLED_DIR}/lib/python3.10/site-packages")

string(COMPARE EQUAL "${VCPKG_TARGET_ARCHITECTURE}" "x64"  SALOME_USE_64BIT_IDS)
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    #WINDOWS_USE_MSBUILD
    OPTIONS 
      --trace-expand
      "-DCONFIGURATION_ROOT_DIR=${SALOME_CONFIGURATION_ROOT_DIR}"
      "-DKERNEL_ROOT_DIR:PATH=${CURRENT_INSTALLED_DIR}"
      "-DGEOM_ROOT_DIR:PATH=${CURRENT_INSTALLED_DIR}"
      "-DSMESH_ROOT_DIR:PATH=${CURRENT_INSTALLED_DIR}"
      -DPYTHON_EXECUTABLE=${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python${VCPKG_HOST_EXECUTABLE_SUFFIX}
      "-DSALOME_INSTALL_PYTHON=tools/python3/Lib/site-packages/salome"
      "-DSALOME_INSTALL_PYTHON_SHARED=tools/python3/Lib/site-packages/salome/shared_modules"
      -DPYTHONLIBS_VERSION_STRING=3.11.5
      -DQT_VERSION=6
      -DOMNIORBPY_ROOT_DIR=${CURRENT_INSTALLED_DIR}/tools/python3/lib/site-packages/omniidl_be
      -DSALOME_USE_64BIT_IDS=${SALOME_USE_64BIT_IDS}
      -DSALOME_BUILD_TESTS=OFF
      -DSALOME_BUILD_DOC=OFF
      -DSALOME_BUILD_GUI=OFF
)

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

vcpkg_cmake_config_fixup(PACKAGE_NAME SalomeNETGENPLUGIN CONFIG_PATH "adm_local/cmake_files")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/SalomeNETGENPLUGIN/SalomeNETGENPLUGINConfig.cmake" "/adm_local/cmake_files" "/share/SalomeNETGENPLUGIN")

if(VCPKG_TARGET_IS_WINDOWS)
  set(file "${CURRENT_PACKAGES_DIR}/share/SalomeNETGENPLUGIN/SalomeNETGENPLUGINTargets-release.cmake")
  file(READ "${file}" contents)
  string(REGEX REPLACE "/lib/([^.]+)\\.dll" "/bin/\\1.dll" contents "${contents}")
  file(WRITE "${file}" "${contents}")

  if(NOT VCPKG_BUILD_TYPE)
    set(file "${CURRENT_PACKAGES_DIR}/share/SalomeNETGENPLUGIN/SalomeNETGENPLUGINTargets-debug.cmake")
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

vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/SalomeNETGENPLUGIN/SalomeNETGENPLUGINConfig.cmake" ";${SWIG_DIR}" "")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
file(REMOVE "${CURRENT_PACKAGES_DIR}/tools/salome/bin/VERSION")
