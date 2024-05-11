vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/srsly
    REF v${VERSION}
    SHA512 105aa0af6c40dc7153f3281221ea764ec57700c2b7bfa10bb6264cc59563a28260ef0b6cb706adbb01f976986f8199ad8849b73e60ccb1b8d1410f95d1a678fa
    HEAD_REF master
    PATCHES
        fix-cython3.patch
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -x)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
