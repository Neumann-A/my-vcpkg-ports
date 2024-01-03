
string(REPLACE "-" "." new_version "${VERSION}")
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO di/calver
    REF ${new_version}
    SHA512 4d436cead8930cae1a71eddef9f0ecd2881f8cb632c3814dc75390b061a909e7ca969a604a5fded1c66647947856d540e2180bd3ce4bed5087b4dbc9d5edb393
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
