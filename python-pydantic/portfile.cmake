vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pydantic/pydantic
    REF v${VERSION}
    SHA512 f15249ce941a801bdc3bcee28c422023cc2a05e3d73cda7cc401e1197cc90a75d1893e2f6b5290b76131c5205c160f673fb02a96552dc0c3680f93736699f6af
    HEAD_REF main
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
