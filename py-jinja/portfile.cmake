vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pallets/jinja
    REF ${VERSION}
    SHA512 48d0ba825329e1266276b406ade616f80ab779b41871b1d57d3c63f866df509da032ad3dcbed23bec95f0e2f1bb23909e8b29f4fc7fe22faea4fe738304df34c
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "jinja2")
