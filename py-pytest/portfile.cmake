vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pytest-dev/pytest
    REF ${VERSION}
    SHA512 f454280c6dea0282d987e68a53792ee5b2c1d2705281c61f48f94a1a058587a59cea2e6fae8bf5cfff25816d6df24c383ef286a797a359dedb9ea7d526b6a156
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
