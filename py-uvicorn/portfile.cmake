vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO encode/uvicorn
    REF ${VERSION}
    SHA512 bb37940acc2eba2a649d07ba44890400332e5ad873ac03c6740c1bc730068ede39c2e6d9aefb0f100ec261d7ed2eef1596c99a060fd8000cff874b25bdbbbdfa
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "uvicorn")
