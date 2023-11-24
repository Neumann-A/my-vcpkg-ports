vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO grantjenks/python-diskcache
    REF v${VERSION}
    SHA512 476d677d88212aa3f9a6e8d12c3e7076cc6a06973d703ed0b2c550b4b4e916b24fb7d8f33c7174854015886fab26e2707b134328d2bc3e144aef5510e7bc0f7c
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
