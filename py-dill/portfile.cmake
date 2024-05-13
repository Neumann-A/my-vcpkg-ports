vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO uqfoundation/dill
    REF ${VERSION}
    SHA512 7c42657bbf7ad49ddbee3d1a55d60e2e53b455f5c60a32c3addcc6457fd2574053155ffed16df6cb56fb30eeed75a4c138b1d34f4fb4c5e95fa93bd567edf2a9
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "dill")
