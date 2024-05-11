vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pyparsing/pyparsing
    REF ${VERSION}
    SHA512 51e463c959d81737ac82ca1c9fb68dbf869d8e0140870e45fc77bdfcf258515dc4ea0a5f4dd1a31ce852bf4947cb1654e096036dd494ebab495214a7e1c97d6e
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
