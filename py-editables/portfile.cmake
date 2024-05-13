vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pfmoore/editables
    REF ${VERSION}
    SHA512 ac39d2e6a51625697c517b85fec11b525b1a41f82cf4f55c7595fed19da867065a62eee5e3656706f7402d0499754f4a142da77d699c59dffc8b769fa1c3dbe2
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "editables")
