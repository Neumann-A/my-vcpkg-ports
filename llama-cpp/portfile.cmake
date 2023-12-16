
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static"  LLAMA_STATIC)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ggerganov/llama.cpp
    REF ${VERSION}
    SHA512 e9d6d648099f33ef989cc8bedb2d83b43464527b33084b4c1dd55bce2cc53160ebd735af711a44749151f1abbb0a4243a5f0bb0614dce580fc024b4221d7e687
    HEAD_REF master
    PATCHES
        mkl.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    DISABLE_PARALLEL_CONFIGURE
    OPTIONS
        -DLLAMA_STATIC=${LLAMA_STATIC}
        -DLLAMA_BLAS:BOOL=ON
        -DLLAMA_CUBLAS:BOOL=ON
        -DLLAMA_BUILD_TESTS:BOOL=ON
        -DLLAMA_BUILD_EXAMPLES:BOOL=OFF
        -DLLAMA_BUILD_SERVER:BOOL=OFF
        -DLLAMA_ACCELERATE:BOOL=OFF
    MAYBE_UNUSED_VARIABLES
        LLAMA_BUILD_SERVER
)
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/Llama PACKAGE_NAME llama)
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/llama/LlamaConfig.cmake" "/../../../" "/../../")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/llama/LlamaConfig.cmake" "${CURRENT_INSTALLED_DIR}" "\${PACKAGE_PREFIX_DIR}")


vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE" )
