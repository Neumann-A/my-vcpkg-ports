vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python-versioneer/python-versioneer
    REF ${VERSION}
    SHA512 36bc69021c7d6c2bfa96b35e797336f8807908fc9ca3948241c18266984ca77af3141d7ff98525168e9c3604f62268b7964627bd211e04e9c0732cde56b62841
    HEAD_REF master
    PATCHES
        fix-build.patch
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
