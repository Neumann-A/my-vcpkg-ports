vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO JuliaLinearAlgebra/libblastrampoline
    REF 81316155d4838392e8462a92bcac3eebe9acd0c7
    SHA512 5f998da2ff1abfd1d4e4ea9fcef9452072aac0d61294179b663d62d666bb67db9442f884877c97d707107e6353ee690a188c8c114d293f53b20709f61ef059c9
    HEAD_REF master
)

## Needs to use clang with --target on windows due to assembly. 

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    )

vcpkg_cmake_install()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")