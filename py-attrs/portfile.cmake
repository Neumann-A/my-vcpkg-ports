vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python-attrs/attrs
    REF ${VERSION}
    SHA512 1797760e80987908bd56649b93c8d29760404f81a0ea88817fc1c2ce013d64f842e59f04639fda96e21d151a72d53ad796ea5ec7c87b39a7fcf2ec2c2cbf9bc6
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "attrs")
