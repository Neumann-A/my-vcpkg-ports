vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO BYU-PRISM/GEKKO
    REF v${VERSION}
    SHA512 c56700ce8e91797a66aafd3ab02bd9ccbd238f653dbea009b3c8c95fced4c2cef27f966d4e59544d0e1b3891e0cc17a9a4eb662e016936cf0675b3fc10f98673
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "gekko")
