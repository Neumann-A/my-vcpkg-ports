vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL "https://git.salome-platform.org/gitpub/modules/smesh.git"
    REF "0d03310b89a97e8afe4e0cdf18c4ce182941011b"
    PATCHES 
      #opencascada-fix.patch
      #undef.patch
      fix-stuff.patch
      fix-build.patch
      fix-occ78.patch
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
      "-DGEOM_ROOT_DIR:PATH=${CURRENT_INSTALLED_DIR}"
      "-DMEDCOUPLING_ROOT_DIR:PATH=${CURRENT_INSTALLED_DIR}"
      "-DSALOME_INSTALL_PYTHON=tools/python3/Lib/site-packages/salome"
      "-DSALOME_INSTALL_PYTHON_SHARED=tools/python3/Lib/site-packages/salome/shared_modules"
      -DPYTHON_EXECUTABLE=${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python${VCPKG_HOST_EXECUTABLE_SUFFIX}
      -DPYTHONLIBS_VERSION_STRING=3.11.5
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

vcpkg_cmake_config_fixup(PACKAGE_NAME SalomeSMESH CONFIG_PATH "adm_local/cmake_files")

set(config "${CURRENT_PACKAGES_DIR}/share/salomesmesh/SalomeSMESHConfig.cmake")
file(READ "${config}" contents)
string(REPLACE "/adm_local/cmake_files" "/share/SalomeSMESH" contents "${contents}")
string(REPLACE "_PREREQ_SalomeSMESH  MEDCoupling MEDFile" "_PREREQ_SalomeSMESH  MEDCoupling MEDFile Eigen3" contents "${contents}")
string(REPLACE "NO_DEFAULT_PATH" "" contents "${contents}")
file(WRITE "${config}" "${contents}")

if(VCPKG_TARGET_IS_WINDOWS)
  set(file "${CURRENT_PACKAGES_DIR}/share/SalomeSMESH/SalomeSMESHTargets-release.cmake")
  file(READ "${file}" contents)
  string(REGEX REPLACE "/lib/([^.]+)\\.dll" "/bin/\\1.dll" contents "${contents}")
  file(WRITE "${file}" "${contents}")

  if(NOT VCPKG_BUILD_TYPE)
    set(file "${CURRENT_PACKAGES_DIR}/share/SalomeSMESH/SalomeSMESHTargets-debug.cmake")
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

vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/SalomeSMESH/SalomeSMESHConfig.cmake" ";${SWIG_DIR}" "")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/SalomeSMESH/SalomeSMESHConfig.cmake" "INCLUDE(\"\${GEOM_ROOT_DIR_EXP}/\${SALOME_INSTALL_CMAKE_LOCAL}/SalomeGEOMTargets.cmake\")" "find_package(SalomeGEOM REQUIRED)")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
file(REMOVE "${CURRENT_PACKAGES_DIR}/tools/salome/bin/VERSION")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/tools/salome/bin/spadder/autotest.sh" "${CURRENT_PACKAGES_DIR}" "$(dirname -- \"$(readlink -f \"\${BASH_SOURCE}\")\")/../../../..")
