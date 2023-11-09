vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO numpy/numpy
    REF 411a55b9ec084c3315fe5f199351c31d0eb3c352
    SHA512 44d46d7c4b1e8a568e63951cf424f49dd47a5f3f9ad673a548c954ba373d353af03e12f07d7fa6f523c1dd91431d0f428d1e24703757928b1e9a0f50ada28ee7
    HEAD_REF main
    PATCHES 
    meson-build.patch
)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH_SIMD
    REPO intel/x86-simd-sort
    REF 3c9bf9a5c69bc90f51e34aa039f914652d8b31cd
    SHA512 1940346206e9988c42dfeb0907d34ac6320db067913c837b14028c89c5f41508c1abc1162996a305430a1186bf824d95129ae48178e77d44120cbf1246230749
    HEAD_REF main
)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH_MESON_NUMPY
    REPO numpy/meson
    REF 067efcb7f59d4cef86c11f9ef7dd64828c48a9b8
    SHA512 f1bb457de6e1123c7a69ee39c39dacfdb01001391dbb78e3c864ca5506029409a6153f951e59e4ba4bb0441340a0c686c95a287087e92856dac4009e6379b5a5
    HEAD_REF main
)

cmake_path(GET SCRIPT_MESON PARENT_PATH MESON_DIR)
file(COPY "${SOURCE_PATH_MESON_NUMPY}/mesonbuild/modules/features" DESTINATION "${MESON_DIR}/mesonbuild/modules")

file(COPY "${SOURCE_PATH_SIMD}/" DESTINATION "${SOURCE_PATH}/numpy/core/src/npysort/x86-simd-sort")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH_SVML
    REPO numpy/SVML
    REF 958caeac44d66878ab36d364c863bde47c0c69e2
    SHA512 444c1f765e875cc3eb55e48bcb8fa0c0d5b2e47cc5db16287e424f16b025cdbaf18f5d5eb6ccee6f5d0311e545ba9b8fdfa0f0cbc09508b38ce372afb339f8c7
    HEAD_REF main
)

file(COPY "${SOURCE_PATH_SVML}/" DESTINATION "${SOURCE_PATH}/numpy/core/src/umath/svml")

x_vcpkg_get_python_packages(PYTHON_VERSION "3" OUT_PYTHON_VAR "PYTHON3" PACKAGES cython)
set(CYTHON "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-venv/Scripts/cython${VCPKG_HOST_EXECUTABLE_SUFFIX}")

set(VCPKG_BUILD_TYPE release) # No debug builds required for pure python modules

vcpkg_replace_string("${SOURCE_PATH}/meson.build" "py.dependency()" "dependency('python-3.11', method : 'pkg-config')")

vcpkg_configure_meson(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
        -Dblas=blas
        -Dlapack=lapack
        -Duse-ilp64=true
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
set(pyfile "${CURRENT_PACKAGES_DIR}/lib/site-packages/numpy/__config__.py")
file(READ "${pyfile}" contents)
string(REPLACE "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-venv/Scripts/" "" contents "${contents}")
string(REPLACE "${CURRENT_INSTALLED_DIR}" "$(prefix)" contents "${contents}")
file(WRITE "${pyfile}" "${contents}")


if(VCPKG_TARGET_IS_WINDOWS)
    file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/")
    file(RENAME "${CURRENT_PACKAGES_DIR}/lib/site-packages/numpy" "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/numpy")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")
endif()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

file(WRITE "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages/numpy-${version}.dist-info/METADATA"
[[
Metadata-Version: 2.1
Name: numpy
Version: 1.26.1
]]
)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
