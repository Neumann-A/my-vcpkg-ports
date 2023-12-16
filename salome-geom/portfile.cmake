vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL "https://git.salome-platform.org/gitpub/modules/geom.git"
    REF "abd699810f0d9758075b9a4158d94d4965b06539"
    PATCHES 
      fix-newer-opencascada.patch
      more-fixes.patch
      fix-link.patch
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static"  SMESH_BUILD_STATIC)

vcpkg_find_acquire_program(SWIG)
cmake_path(GET SWIG PARENT_PATH SWIG_DIR)
vcpkg_add_to_path("${SWIG_DIR}")

set(ENV{PYTHONPATH} "${CURRENT_HOST_INSTALLED_DIR}/tools/python3/Lib;${CURRENT_INSTALLED_DIR}/lib/python3.10/site-packages")

string(COMPARE EQUAL "${VCPKG_TARGET_ARCHITECTURE}" "x64"  SALOME_USE_64BIT_IDS)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
      "-DCONFIGURATION_ROOT_DIR=${SALOME_CONFIGURATION_ROOT_DIR}"
      "-DKERNEL_ROOT_DIR:PATH=${CURRENT_INSTALLED_DIR}"
      -DPYTHON_EXECUTABLE=${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python${VCPKG_HOST_EXECUTABLE_SUFFIX}
      -DSALOME_USE_64BIT_IDS=${SALOME_USE_64BIT_IDS}
      -DSALOME_BUILD_TESTS=OFF
      -DSALOME_BUILD_DOC=OFF
      -DSALOME_BUILD_GUI=OFF
      -DSALOME_GEOM_USE_VTK=ON
      "-DOpenCASCADE_INCLUDE_DIR=${CURRENT_INSTALLED_DIR}/include/opencascade"
      -DOPENCASCADE_ROOT_DIR=${CURRENT_INSTALLED_DIR}/share/opencascade
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

file(GLOB idl_pys "${CURRENT_PACKAGES_DIR}/bin/salome/*idl.py")
foreach(idl_py IN LISTS idl_pys)
  file(READ "${idl_py}" contents)
  string(REPLACE "r\"${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/idl" "os.path.realpath(os.path.dirname(__file__)) + \"/../../../../idl/salome" contents "${contents}")
  string(REPLACE "${CURRENT_BUILDTREES_DIR}" "" contents "${contents}")
  file(WRITE "${idl_py}" "${contents}")
endforeach()

vcpkg_cmake_config_fixup(PACKAGE_NAME SalomeGEOM CONFIG_PATH "adm_local/cmake_files")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/salomegeom/SalomeGEOMConfig.cmake" "/adm_local/cmake_files" "/share/SalomeGEOM")

if(VCPKG_TARGET_IS_WINDOWS)
  set(file "${CURRENT_PACKAGES_DIR}/share/SalomeGEOM/SalomeGEOMTargets-release.cmake")
  file(READ "${file}" contents)
  string(REGEX REPLACE "/lib/([^.]+)\\.dll" "/bin/\\1.dll" contents "${contents}")
  file(WRITE "${file}" "${contents}")

  if(NOT VCPKG_BUILD_TYPE)
    set(file "${CURRENT_PACKAGES_DIR}/share/SalomeGEOM/SalomeGEOMTargets-debug.cmake")
    file(READ "${file}" contents)
    string(REGEX REPLACE "/lib/([^.]+)\\.dll" "/bin/\\1.dll" contents "${contents}")
    file(WRITE "${file}" "${contents}")
  endif()
endif()

file(RENAME "${CURRENT_PACKAGES_DIR}/bin/salome" "${CURRENT_PACKAGES_DIR}/tools/salome/bin/salome")

vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/SalomeGEOM/SalomeGEOMConfig.cmake" ";${SWIG_DIR}" "")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")

file(REMOVE "${CURRENT_PACKAGES_DIR}/tools/salome/bin/VERSION")
