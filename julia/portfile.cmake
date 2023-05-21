vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO JuliaLang/julia
    REF d2f5bbd7cfbac902db952b465b83d242efcf6f08 # 78fbf1bd74ded2a8a830f9f4b35c98666f2a7e16 #8e630552924eac54c809aa7bc30871c7df1582d3
    SHA512 fcf204f0900399d40f535377b400110f1b997fbe4baf5bc9a055c7fa54d238f50887c2025379ccacf7789e8ae6566972bc77def114b21f22bd1a512a4678a1c9 # 3984ece9df04ef3448df7a80013e65205ab0d8c6016f7d9468934e09dffceddb38bb435f70c6888a043c87d5788c731b18c8e897659feb1364c7f51bd793fac9 #6b7513322f3a10d58cbce81a526138bbe23ffa07274c74e7846f68fddd78aeec5ec375624957d688887c02e787258a71f648f465ef4933f4aa7b514924ba8cb1
    HEAD_REF master
    PATCHES 
        makefiles.patch
        libnames.patch
        external-libuv.patch
        external-utf8proc.patch
        remaining.patch
)

vcpkg_find_acquire_program(PYTHON3)
#x_vcpkg_get_python_packages(PYTHON_EXECUTABLE "${PYTHON3}" PACKAGES html5lib)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
vcpkg_add_to_path("${PYTHON3_DIR}")
vcpkg_find_acquire_program(PERL)
#x_vcpkg_get_python_packages(PYTHON_EXECUTABLE "${PYTHON3}" PACKAGES html5lib)
get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
vcpkg_add_to_path("${PERL_DIR}")

vcpkg_cmake_get_vars(cmake_vars_file)
file(TOUCH "${SOURCE_PATH}/configure")
vcpkg_configure_make(
    SOURCE_PATH "${SOURCE_PATH}"
    SKIP_CONFIGURE
    COPY_SOURCE
    USE_WRAPPERS
    )



include("${cmake_vars_file}")
if(VCPKG_DETECTED_CMAKE_C_COMPILER_ID STREQUAL "MSVC")
    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
        string(APPEND asmflags " --target=i686-pc-windows-msvc")
    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
        string(APPEND asmflags " --target=x86_64-pc-windows-msvc")
    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
        string(APPEND asmflags " --target=arm64-pc-windows-msvc")
    endif()
    vcpkg_find_acquire_program(CLANG)
    set(ccas "${CLANG}")
else()
    set(ccas "${VCPKG_DETECTED_CMAKE_C_COMPILER}")
endif()

if(ccas)
    cmake_path(GET ccas PARENT_PATH ccas_dir)
    vcpkg_add_to_path("${ccas_dir}")
    cmake_path(GET ccas FILENAME ccas_command)
    set(ENV{CCAS} "${ccas_command}")
    set(ENV{CCASFLAGS} "${asmflags}")
endif()

vcpkg_add_to_path("${CURRENT_INSTALLED_DIR}/tools/llvm")
vcpkg_add_to_path(PREPEND "${CMAKE_CURRENT_LIST_DIR}")
set(ENV{CC} "compile clang-cl")
set(ENV{CXX} "compile clang-cl")
#vcpkg_build_make(
#    BUILD_TARGET all
#    SUBPATH deps
#)
set(ENV{LBT_DEFAULT_LIBS} "mkl_rt.2.dll;mkl_blacs_ilp64.2.dll;mkl_blacs_lp64.2.dll;mkl_core.2.dll")
set(VCPKG_CONCURRENCY 1)
vcpkg_build_make(
    ADD_BIN_TO_PATH
    BUILD_TARGET all
    #SUBPATH src
)