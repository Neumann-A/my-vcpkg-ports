vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pitrou/pyarrow-hotfix
    REF v${VERSION}
    SHA512 916457406ef7adff55c3f5a44162b5b8dc8818ab8ee99ddef01e6f69df88d789f4ce33065e52f15e51aa98062eab589647c22ed6c3fed0702825a1788b70470b
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
