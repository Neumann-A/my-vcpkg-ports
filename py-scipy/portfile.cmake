# TODO: Needs Fortran setup

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO scipy/scipy
    REF v${VERSION}
    SHA512 a8c15274282444c62b42b456225fd496e6b7f52aa7aa35d349c6d6a9f2c5fd077042d24be643ee722d915add400f8df35cccc71b19dce3d3f297180ce0923e56
    HEAD_REF main
    PATCHES

)

x_vcpkg_get_python_packages(PYTHON_VERSION "3" OUT_PYTHON_VAR "PYTHON3" PACKAGES cython)
set(CYTHON "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-venv/Scripts/cython${VCPKG_HOST_EXECUTABLE_SUFFIX}")

set(VCPKG_BUILD_TYPE release) # No debug builds required for pure python modules

#vcpkg_replace_string("${SOURCE_PATH}/meson.build" "py.dependency()" "dependency('python-3.11', method : 'pkg-config')")

x_vcpkg_find_fortran(OPTIONS fortran_opts OPTIONS_RELEASE fortran_opts_rel)

list(APPEND VCPKG_CMAKE_CONFIGURE_OPTIONS "-DVCPKG_LANGUAGES=C\;CXX\;Fortran")
list(APPEND VCPKG_CMAKE_CONFIGURE_OPTIONS "${fortran_opts}")
list(APPEND VCPKG_CMAKE_CONFIGURE_OPTIONS_RELEASE "${fortran_opts_rel}")

vcpkg_configure_meson(
    SOURCE_PATH "${SOURCE_PATH}"
    LANGUAGES C CXX Fortran
    OPTIONS 
        -Dblas=blas
        -Dlapack=lapack
        #-Duse-ilp64=true
    ADDITIONAL_BINARIES
      cython=['${CYTHON}']
      python3=['${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python${VCPKG_HOST_EXECUTABLE_SUFFIX}']
      python=['${CURRENT_HOST_INSTALLED_DIR}/tools/python3/python${VCPKG_HOST_EXECUTABLE_SUFFIX}']
    )
vcpkg_install_meson()
vcpkg_fixup_pkgconfig()

# edit E:\all\vcpkg\installed\x64-win-llvm-release\lib\site-packages\numpy\__config__.py
	# line  43:                 "commands": "E:/b/numpy/x64-win-llvm-release-venv/Scripts/cython.exe",
	# line  76:                 "pc file directory": r"E:/all/vcpkg/installed/x64-win-llvm-release/lib/pkgconfig",
	# line  84:                 "lib directory": r"E:/all/vcpkg/installed/x64-win-llvm-release/lib",
	# line  86:                 "pc file directory": r"E:/all/vcpkg/installed/x64-win-llvm-release/lib/pkgconfig",
	# line  90:             "path": r"E:\b\numpy\x64-win-llvm-release-venv\Scripts\python.exe",
#set(pyfile "${CURRENT_PACKAGES_DIR}/lib/site-packages/numpy/__config__.py")
#file(READ "${pyfile}" contents)
#string(REPLACE "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-venv/Scripts/" "" contents "${contents}")
#string(REPLACE "${CURRENT_INSTALLED_DIR}" "$(prefix)" contents "${contents}")
#file(WRITE "${pyfile}" "${contents}")


#if(VCPKG_TARGET_IS_WINDOWS)
#    file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/")
#    file(RENAME "${CURRENT_PACKAGES_DIR}/lib/site-packages/numpy" "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/numpy")#
#    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")
#endif()

#file(REMOVE_RECURSE
#    "${CURRENT_PACKAGES_DIR}/debug/include"
#    "${CURRENT_PACKAGES_DIR}/debug/share"
#)

#vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

file(WRITE "${CURRENT_PACKAGES_DIR}/${PYTHON3_SITE}/numpy-${version}.dist-info/METADATA"
[[
Metadata-Version: 2.1
Name: numpy
Version: 1.26.1
]]
)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "scipy")
