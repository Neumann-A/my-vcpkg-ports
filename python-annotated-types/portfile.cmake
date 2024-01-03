vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO annotated-types/annotated-types
    REF v${VERSION}
    SHA512 c4125cdfdc6a16561ac885c97b4300ebe8fe36c0b3ebdf59429002734bf77afb88ffe6c7aa03fdb9a0e5c793c55d3cf825695f1a2d279abf6f366a945447959d
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
