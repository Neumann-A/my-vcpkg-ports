vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python-trio/sniffio
    REF v${VERSION}
    SHA512 34e2e0a2e1c43e4ce1e1b5cdfb16c4f872897bbc7da77a76b55dc9cae475d87fe1e35d7103cad68ddab93c8be743aaa312ec12b1ddd96ad968be027faa24839f
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST 
  "${SOURCE_PATH}/LICENSE"
  "${SOURCE_PATH}/LICENSE.APACHE2"
  "${SOURCE_PATH}/LICENSE.MIT")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "sniffio")
