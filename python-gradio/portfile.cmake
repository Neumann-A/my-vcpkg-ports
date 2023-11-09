vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO gradio-app/gradio
    REF v${VERSION}
    SHA512 991e43562e5f44c4aeaf2f87cb4e676c6d65f0ea4732000a19a394e7e0eb6198f92adab207607e8e23f1a3b0a35f240014604bce013c3d57d3ade23097a537fb
    HEAD_REF main
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
