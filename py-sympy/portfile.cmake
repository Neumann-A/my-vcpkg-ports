vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sympy/sympy
    REF sympy-${VERSION}
    SHA512 96a89b88f6912d70c56f5bd1903dd3c518963118ff25d033cdcb7da2f260b8ee209d3ab4a4394dd2b5dc0b4585b71ccd55d55c8e5c6e28024cccbedf07ee4360
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "sympy")
