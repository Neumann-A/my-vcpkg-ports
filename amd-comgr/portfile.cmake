#https://github.com/ROCm-Developer-Tools/HIP/blob/develop/docs/developer_guide/build.md

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO RadeonOpenCompute/llvm-project
    REF "aabd1b69344600d553ce074acbd2932269c5a69a"
    SHA512 1f101fd60332c58a2b52c591851d0f24c3b8297daa742a1e3ea10768a95316e8b21bc39ea46164a97f15ed050f99387519c4f73744c7aaa968ddaba7d1d5ff58
    HEAD_REF master
)



vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/amd/device-libs"
    OPTIONS

)
vcpkg_cmake_install()
vcpkg_cmake_config_fixup()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/amd/comgr"
    OPTIONS
)
vcpkg_cmake_install()
