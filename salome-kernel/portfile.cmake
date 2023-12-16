vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY) # hardcoded set(BUILD_SHARED_LIBS TRUE)

vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL "https://git.salome-platform.org/gitpub/modules/kernel.git"
    REF "5b6831fd8b2e3de8c64f9117977cadd47fe7ddcf"
    PATCHES wip.patch
)

string(COMPARE EQUAL "${VCPKG_TARGET_ARCHITECTURE}" "x64"  SALOME_USE_64BIT_IDS)

vcpkg_find_acquire_program(SWIG)
cmake_path(GET SWIG PARENT_PATH SWIG_DIR)
vcpkg_add_to_path("${SWIG_DIR}")
set(ENV{PYTHONPATH} "${CURRENT_HOST_INSTALLED_DIR}/tools/python3/Lib;${CURRENT_INSTALLED_DIR}/lib/python3.11/site-packages")
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
      "-DCONFIGURATION_ROOT_DIR=${SALOME_CONFIGURATION_ROOT_DIR}"
      -DSALOME_BUILD_TESTS=OFF
      -DSALOME_BUILD_DOC=OFF
      -DSALOME_USE_64BIT_IDS=${SALOME_USE_64BIT_IDS}
      -DPYTHON_EXECUTABLE=${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python${VCPKG_HOST_EXECUTABLE_SUFFIX}
      "-DSALOME_INSTALL_PYTHON=tools/python3/Lib/site-packages/salome"
      "-DSALOME_INSTALL_PYTHON_SHARED=tools/python3/Lib/site-packages/salome/shared_modules"
      -DOMNIORB_IDL_COMPILER=${CURRENT_HOST_INSTALLED_DIR}/tools/omniorb/bin/omniidl${VCPKG_HOST_EXECUTABLE_SUFFIX}
      -DOMNIORB_OMNINAMES_COMMAND=${CURRENT_HOST_INSTALLED_DIR}/tools/omniorb/bin/omniNames${VCPKG_HOST_EXECUTABLE_SUFFIX}
      -DOMNIORBPY_ROOT_DIR=${CURRENT_INSTALLED_DIR}/tools/python3/lib/site-packages/omniidl_be
      -DPYTHON_INCLUDE_DIR=${CURRENT_INSTALLED_DIR}/include/python3.11
      -DSALOME_INSTALL_CMAKE:PATH=share/salomekernel
      -DSALOME_INSTALL_SCRIPT_DATA:PATH=share/salome/script
      -DSALOME_INSTALL_SCRIPT_PYTHON:PATH=share/salome/script
      -DSALOME_INSTALL_SCRIPT_SCRIPTS:PATH=share/salome/script
      -DSALOME_INSTALL_APPLISKEL_SCRIPTS:PATH=share/salome/appliskel
      -DSALOME_INSTALL_APPLISKEL_PYTHON:PATH=share/salome/appliskel
      -DSALOME_INSTALL_BINS:PATH=tools/salome/bin
      -DSALOME_INSTALL_LIBS:PATH=lib
    OPTIONS_DEBUG
      -DPYTHONLIBS_ROOT_DIR=${CURRENT_INSTALLED_DIR}/debug/lib
    OPTIONS_RELEASE
      -DPYTHONLIBS_ROOT_DIR=${CURRENT_INSTALLED_DIR}/lib
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

vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/salomekernel/SalomeKERNELConfig.cmake" ";${SWIG_DIR}" "")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/salomekernel/SalomeKERNELConfig.cmake" "SET_AND_CHECK(SWIG_ROOT_DIR_EXP     \"${SWIG_DIR}\")" "")

# TODO remove NO_MODULE from Config.cmake

file(RENAME "${CURRENT_PACKAGES_DIR}/bin/salome" "${CURRENT_PACKAGES_DIR}/tools/salome/bin/salome")



vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
vcpkg_copy_tool_dependencies("${CURRENT_PACKAGES_DIR}/tools/salome/bin")