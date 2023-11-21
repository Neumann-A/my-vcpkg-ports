vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pytoolz/toolz
    REF ${VERSION}
    SHA512 d012ebdba5621579b1122e1711c58d255b61962c2bfb41d2f91d1c48bf809f00ea33c583202f417c488f65f57353a1af7a8994f4fbb6bb021bb2ef94a5a2ee42
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
