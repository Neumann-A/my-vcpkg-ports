vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/thinc
    REF v${VERSION}
    SHA512 523ed92f0559d18e17467734673fa33050d6f587217a286da094c5e3ff351bfdf7fa94f1dc29fcbd244018d3949428a5546540b8839c47339016ddb3ec4bd632
    HEAD_REF master
    PATCHES
      cython3.patch
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "thinc")
