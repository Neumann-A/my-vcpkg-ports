set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO coin3d/pivy
    REF 83e99c18545bb66145716123151f6635c367533b
    SHA512 1c2101b8d02f8751eb2bc10ac1673c7672c8722956552d4459cb20d9c71d10837de01e023f487cbfb456f4876bc357ea5649c3e02b0ac758d32e14cca4535698
    HEAD_REF master
    PATCHES fix-install-dest.diff
)

vcpkg_find_acquire_program(SWIG)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
      "-DSWIG_EXECUTABLE=${SWIG}"
)

vcpkg_cmake_install()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

