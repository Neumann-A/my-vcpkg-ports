vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO giampaolo/psutil
    REF release-${VERSION}
    SHA512 716a39e5a5e278717a14b74786f8b941f0b4335f6e0c4de338346b825925e8793315f41908ec10bbb97ed6f9a9e5ffca27e031377025f03d73300876b9ff60e8
    HEAD_REF main
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
