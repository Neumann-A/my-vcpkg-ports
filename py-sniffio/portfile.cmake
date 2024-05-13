vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python-trio/sniffio
    REF v${VERSION}
    SHA512 3a9584eea20f5a69958f206fad9f01ef7fc40735f48a6cfaa11ba6eea1e7b8cc8c8053416595fe23276e162b0ab5dd6a41fb30bd9f7994f03b3d3242d5b40ef6
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST 
  "${SOURCE_PATH}/LICENSE"
  "${SOURCE_PATH}/LICENSE.APACHE2"
  "${SOURCE_PATH}/LICENSE.MIT")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "sniffio")
