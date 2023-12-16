vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL "https://git.salome-platform.org/gitpub/modules/med.git"
    REF "d0a1739f565d2e6cb47002ea650094895f4bbfd4"
    PATCHES
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static"  MEDCOUPLING_BUILD_STATIC)

set(ENV{PYTHONPATH} "${CURRENT_HOST_INSTALLED_DIR}/tools/python3/Lib;${CURRENT_INSTALLED_DIR}/lib/python3.10/site-packages")

string(COMPARE EQUAL "${VCPKG_TARGET_ARCHITECTURE}" "x64"  SALOME_USE_64BIT_IDS)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
      "-DCONFIGURATION_ROOT_DIR=${SALOME_CONFIGURATION_ROOT_DIR}"
      "-DKERNEL_ROOT_DIR:PATH=${CURRENT_INSTALLED_DIR}"
      "-DMEDCOUPLING_ROOT_DIR=${CURRENT_INSTALLED_DIR}"
      -DPYTHON_EXECUTABLE=${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python${VCPKG_HOST_EXECUTABLE_SUFFIX}
      "-DSALOME_INSTALL_PYTHON=tools/python3/Lib/site-packages/salome"
      "-DSALOME_INSTALL_PYTHON_SHARED=tools/python3/Lib/site-packages/salome/shared_modules"
      -DSALOME_USE_64BIT_IDS=${SALOME_USE_64BIT_IDS}
      -DSALOME_BUILD_TESTS=OFF
      -DSALOME_BUILD_DOC=OFF
      -DSALOME_BUILD_GUI=OFF
      -DSALOME_FIELDS_ENABLE_PYTHON=OFF
      -DSALOME_INSTALL_SCRIPT_DATA:PATH=share/salome/script
      -DSALOME_INSTALL_SCRIPT_PYTHON:PATH=share/salome/script
      -DSALOME_INSTALL_SCRIPT_SCRIPTS:PATH=share/salome/script
      -DSALOME_INSTALL_BINS:PATH=tools/salome/bin
      -DSALOME_INSTALL_LIBS:PATH=lib
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

vcpkg_cmake_config_fixup(PACKAGE_NAME SalomeFIELDS CONFIG_PATH "adm_local/cmake_files")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/SalomeFIELDS/SalomeFIELDSConfig.cmake" "/adm_local/cmake_files" "/share/SalomeFIELDS")
if(VCPKG_TARGET_IS_WINDOWS)
  set(file "${CURRENT_PACKAGES_DIR}/share/SalomeFIELDS/SalomeFIELDSTargets-release.cmake")
  file(READ "${file}" contents)
  string(REGEX REPLACE "/lib/([^.]+)\\.dll" "/bin/\\1.dll" contents "${contents}")
  file(WRITE "${file}" "${contents}")

  if(NOT VCPKG_BUILD_TYPE)
    set(file "${CURRENT_PACKAGES_DIR}/share/SalomeFIELDS/SalomeFIELDSTargets-debug.cmake")
    file(READ "${file}" contents)
    string(REGEX REPLACE "/lib/([^.]+)\\.dll" "/bin/\\1.dll" contents "${contents}")
    file(WRITE "${file}" "${contents}")
  endif()
endif()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")

file(REMOVE "${CURRENT_PACKAGES_DIR}/tools/salome/bin/VERSION")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share/salome/script/test")
