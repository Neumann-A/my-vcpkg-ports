vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python/importlib_metadata
    REF v${VERSION}
    SHA512 58bea523993a0fed8b7db5ffa29a4aec6214229117b8aea3cebebcccc898c2ed0ed78df99fb5f0aa9057cff77b50a6402b39dfe4f475a832ee1518f98e5a56ae
    HEAD_REF main
)

# -x to avoid setuptools_scm cycle. 
vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "importlib_metadata")
