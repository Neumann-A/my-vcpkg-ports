vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pypa/hatch
    REF hatchling-v${VERSION}
    SHA512 e83f57089707a267685c9cac7f29cd5862adec62f6346097aa62bd5b3b9f7222621b2ea71004dd52f62798dab71bcf05c33a2c43dbe39d1bbc5f4a4f99f28c40
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}/backend")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "hatchling")
