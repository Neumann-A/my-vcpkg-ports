vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pallets/jinja
    REF ${VERSION}
    SHA512 50feebc7eed4c8b5bb0c2951784c1c115e3ee1c0e0c91bbf1884551b1312ef8fce24804a2ca1dfd8c543406529afe4817567c39e7cfd15028b54049853623144
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.rst")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
