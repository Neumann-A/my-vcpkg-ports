vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO repo-helper/hatch-requirements-txt
    REF v${VERSION}
    SHA512 f6049563e955cb6bb25da8a19ed84f08de26f96cd855787cabb16e7be1e946e1e3341f204dffca225b81f1a7c39536a4a1c7081bfce40cb146cf2c7eb6607ac7
    HEAD_REF main
    PATCHES
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
