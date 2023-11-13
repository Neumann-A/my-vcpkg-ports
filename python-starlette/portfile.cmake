vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO encode/starlette
    REF ${VERSION}
    SHA512 4b655af29e0a2e031db4155e8697d23abee1e100735904a47b0989faf56a9a05c007a672e6576748849347aaab931c8c1ea89a09d77b04ac8b55a78284ab551a
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
