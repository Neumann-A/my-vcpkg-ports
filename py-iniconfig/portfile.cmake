vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pytest-dev/iniconfig
    REF v${VERSION}
    SHA512 e474aaa904070ed79dbbd2b4b572574ebb591b97a4ca0f9c4e4aef437af01035d2f73c48bb670afcec2cd8b7ea093b92d6b0c0eca7ba42033418a2b0e0ac80ad
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
