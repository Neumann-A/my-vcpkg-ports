
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static"  LLAMA_STATIC)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ggerganov/llama.cpp
    REF ${VERSION}
    SHA512 2e0e02b8001c69f16f980a11544622c14cba1fc53d0b2a5afe24bbe8123b08af7c526701446f60c6a475dbae1615f2df3116aadb8f96cd474a8716ab7d19c1dc
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
        -DLLAMA_BUILD_TESTS:BOOL=OFF
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
