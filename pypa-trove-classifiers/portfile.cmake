
string(REPLACE "-" "." new_version "${VERSION}")
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pypa/trove-classifiers
    REF ${new_version}
    SHA512 5089e5b300a85c41837ae22838712fa7d0e3934b91efd2e3fc1ff3f9389915be30be6dcd8ad9273f6923b7c590802f2fdb95ad5f34412852f58539ee41c79c9c
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
