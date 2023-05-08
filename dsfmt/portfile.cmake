vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO MersenneTwister-Lab/dSFMT
    REF 6929b76f2ab07e6302f8daece28045d5bec6ff5c
    SHA512 5b2b7fea75b2f707d39af7a0dd5bd858370cd346f2cd97318a4cf40b75b674369f0466d7ff62b28cb07294f3c53d7db2a1bee6adeeb4589f7ac23c4ebaf20de3
    HEAD_REF master
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")
vcpkg_cmake_install()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")