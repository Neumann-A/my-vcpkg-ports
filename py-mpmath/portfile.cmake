vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mpmath/mpmath
    REF ${VERSION}
    SHA512 ec703e661323035e3c973fc2e52206e793f6182ed9897e5a483cb35a22421d7869df850cdd89fc1ef4e1bb28b17b4914447116dbeed136a687e582cce0bf9e42
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "mpmath")
