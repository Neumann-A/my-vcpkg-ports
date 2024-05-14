vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO grantjenks/python-sortedcontainers
    REF v${VERSION}
    SHA512 f80185c6f95a85cc78f88f6f6cf389eb48be22cf94d5fcd84f3592873f17de37ec7f44c1627b7f02956ac4b4f74ca4febefc47d3c6232f70ee05dbb2449ad770
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "sortedcontainers")
