vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Python-Markdown/markdown
    REF ${VERSION}
    SHA512 42a957f4a25b77d74658989dfbda99a200244ffc8c21a32287a0faf846dc0d6b2474838ca55985c60872c6b3d66482f097ac48138440c5a13c52d61a73090a0c
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
