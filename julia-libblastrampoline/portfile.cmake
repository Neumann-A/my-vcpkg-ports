vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO JuliaLinearAlgebra/libblastrampoline
    REF 81316155d4838392e8462a92bcac3eebe9acd0c7
    SHA512 5f998da2ff1abfd1d4e4ea9fcef9452072aac0d61294179b663d62d666bb67db9442f884877c97d707107e6353ee690a188c8c114d293f53b20709f61ef059c9
    HEAD_REF master
    PATCHES 
      make-msvc-work.patch
      strdup.patch
)

file(TOUCH "${SOURCE_PATH}/configure")
vcpkg_configure_make(
    SOURCE_PATH "${SOURCE_PATH}"
    SKIP_CONFIGURE
    COPY_SOURCE
    USE_WRAPPERS
    )

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

if(ccas)
    cmake_path(GET ccas PARENT_PATH ccas_dir)
    vcpkg_add_to_path("${ccas_dir}")
    cmake_path(GET ccas FILENAME ccas_command)
    set(ENV{CCAS} "${ccas_command}")
    set(ENV{CCASFLAGS} "${asmflags}")
endif()

cmake_path(GET VCPKG_DETECTED_CMAKE_C_COMPILER FILENAME CC)
cmake_path(GET VCPKG_DETECTED_CMAKE_AR FILENAME AR)
set(ENV{CC} "compile ${CC}")
set(ENV{CFLAGS} "${VCPKG_DETECTED_CMAKE_C_FLAGS_RELEASE}")
set(ENV{LDFLAGS} "${VCPKG_DETECTED_CMAKE_SHARED_LINKER_FLAGS_RELEASE}")
set(ENV{AR} "ar-lib ${AR}")

set(all_buildtypes release)
set(short_name_release rel)
if(NOT VCPKG_BUILD_TYPE)
    list(APPEND all_buildtypes debug)
    set(short_name_dbg dbg)
endif()
foreach(current_buildtype IN LISTS all_buildtypes)
    set(target_dir "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-${short_name_${current_buildtype}}")
    file(MAKE_DIRECTORY "${target_dir}")
    file(COPY "${SOURCE_PATH}/" DESTINATION "${target_dir}")
endforeach()

vcpkg_build_make(
    SUBPATH src
    BUILD_TARGET all
)

file(COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/src/build/libblastrampoline-5.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
file(COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/src/build/libblastrampoline-5.dll"
          "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/src/build/libblastrampoline-5.pdb"
    DESTINATION "${CURRENT_PACKAGES_DIR}/bin")

file(COPY "${SOURCE_PATH}/include/"
    DESTINATION "${CURRENT_PACKAGES_DIR}/include/libblastrampoline")
file(COPY "${SOURCE_PATH}/src/libblastrampoline.h"
    DESTINATION "${CURRENT_PACKAGES_DIR}/include/")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/include/libblastrampoline/ILP64/common")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")