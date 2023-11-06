
vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" )
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static"  LLAMA_STATIC)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ggerganov/llama.cpp
    REF ${VERSION}
    SHA512 0
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DLLAMA_STATIC=${LLAMA_STATIC}
        -DLLAMA_BLAS:BOOL=ON
        -DLLAMA_CUBLAS:BOOL=ON
        -DLLAMA_BUILD_TESTS:BOOL=OFF
        -DLLAMA_BUILD_EXAMPLES:BOOL=OFF
        -DLLAMA_BUILD_SERVER:BOOL=OFF
)
vcpkg_cmake_install()
vcpkg_cmake_config_fixup()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE" )
