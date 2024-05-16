if(VCPKG_TARGET_IS_WINDOWS)
    vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Maratyszcza/pthreadpool
    REF 178e3e0646cc671708bf78e77c273940130ac637 # there is a too much gap from the last release...
    SHA512 160f4beba1ccbb73eb2a8c51eb0719da0d981934492fdd1b795fc9adf36200870887bee29eca3c398aea197c6a047cd81f9aec133adf9c48f101fdd340e59660
    PATCHES
        fix-cmakelists.patch
        fix-uwp.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DPTHREADPOOL_BUILD_TESTS=OFF
        -DPTHREADPOOL_BUILD_BENCHMARKS=OFF
)
vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_cmake_config_fixup(PACKAGE_NAME unofficial-${PORT})

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
