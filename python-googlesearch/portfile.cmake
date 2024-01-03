vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO MarioVilas/googlesearch
    REF v${VERSION}
    SHA512 c7b06f55ec454d1d6170d1506955cec8ac4776029d46374eaaab5019999659c18c499a580d3a550b552c01a52585ca0f3a4d8e741639fa666c5009a06b203169
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
