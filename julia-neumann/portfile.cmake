#vcpkg_from_github(
#    OUT_SOURCE_PATH SOURCE_PATH
#    REPO Neumann-A/julia
#    REF 
#    SHA512 
#    HEAD_REF master
#)

vcpkg_find_acquire_program(PYTHON3)
#x_vcpkg_get_python_packages(PYTHON_EXECUTABLE "${PYTHON3}" PACKAGES html5lib)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
vcpkg_add_to_path("${PYTHON3_DIR}")
vcpkg_find_acquire_program(PERL)
get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
vcpkg_add_to_path("${PERL_DIR}")
vcpkg_find_acquire_program(7Z)
get_filename_component(7Z_DIR "${7Z}" DIRECTORY)
vcpkg_add_to_path("${7Z_DIR}")

vcpkg_cmake_get_vars(cmake_vars_file)
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

set(cmakeopts 
        "-DCMAKE_ASM_COMPILER=${ccas}"
        "-DCMAKE_ASM_FLAGS=${asmflags}"
)

set(SOURCE_PATH "E:/julia")
set(ENV{LBT_DEFAULT_LIBS} "mkl_rt.2.dll")
# file(GLOB jl_stdlib_version_files "${SOURCE_PATH}/stdlib/*.version")
# foreach(jl_stdlib_version_file IN LISTS jl_stdlib_version_files)
    # file(STRINGS "${jl_stdlib_version_file}" stdlib_version_info)
    # cmake_path(GET jl_stdlib_version_file STEM stdlib_name)

    # set(stdlib_git_url "${stdlib_version_info}")
    # list(FILTER stdlib_git_url INCLUDE REGEX "_GIT_URL")
    # string(REGEX REPLACE "[^=]+=[ \t]+" "" stdlib_git_url "${stdlib_git_url}")

    # set(stdlib_sha1_ref "${stdlib_version_info}")
    # list(FILTER stdlib_sha1_ref INCLUDE REGEX "_SHA1")
    # string(REGEX REPLACE "[^=]+=[ \t]+" "" stdlib_sha1_ref "${stdlib_sha1_ref}")

    # set(stdlib_branch "${stdlib_version_info}")
    # list(FILTER stdlib_branch INCLUDE REGEX "_BRANCH")
    # string(REGEX REPLACE "[^=]+=[ \t]+" "" stdlib_branch "${stdlib_branch}")

    # string(TOLOWER "${stdlib_name}" stdlib_lower_name)

    # vcpkg_from_git(
      # OUT_SOURCE_PATH SOURCE_PATH_${stdlib_name}
      # URL "${stdlib_git_url}"
      # REF "${stdlib_sha1_ref}"
    # )
    
    # #file(COPY "${SOURCE_PATH_${stdlib_name}}/" DESTINATION "${SOURCE_PATH}/stdlib/${stdlib_name}")
# endforeach()

#list(APPEND VCPKG_CMAKE_CONFIGURE_OPTIONS "-DFETCHCONTENT_FULLY_DISCONNECTED=OFF")
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
        ${cmakeopts}
        #--trace-expand
)
vcpkg_cmake_install(ADD_BIN_TO_PATH
)
