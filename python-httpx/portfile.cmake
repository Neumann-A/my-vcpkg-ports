vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO encode/httpx
    REF ${VERSION}
    SHA512 ad67f45162e328dba3d74abc75cdae02cc4da1605e21456fbb2023f9f515efa6ec6c5799927a4a4557cf439819f9b05dc2805002e29b97102dadcf934cbd0e2b
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
