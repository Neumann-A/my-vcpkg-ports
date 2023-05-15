vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO JuliaLang/julia
    REF 8e630552924eac54c809aa7bc30871c7df1582d3
    SHA512 6b7513322f3a10d58cbce81a526138bbe23ffa07274c74e7846f68fddd78aeec5ec375624957d688887c02e787258a71f648f465ef4933f4aa7b514924ba8cb1
    HEAD_REF master
    PATCHES 
        wip.patch
        wip2.patch
        wip3.patch
        wip4.patch
        wip5.patch
)

vcpkg_find_acquire_program(PYTHON3)
#x_vcpkg_get_python_packages(PYTHON_EXECUTABLE "${PYTHON3}" PACKAGES html5lib)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
vcpkg_add_to_path("${PYTHON3_DIR}")


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
set(VCPKG_CONCURRENCY 1)
vcpkg_build_make(
    ADD_BIN_TO_PATH
    BUILD_TARGET all
    #SUBPATH src
)