vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pdm-project/pdm-backend
    REF ${VERSION}
    SHA512 0169b97b662a0520c9810d566b74b6ef378db083954064ee37e8ed8cc40375a556500c307cebb9e269c3192b9f9b8659f575f0d24d67f970b3797e2354b53d54
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

#vcpkg_python_test_import(MODULE "pdm")
