vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python-jsonschema/jsonschema-specifications
    REF v${VERSION}
    SHA512 686b391d583c0444858c579b946309c7c9f901c6556bacd8f102da3e5a859173ef670f61acd091fff89ad3f4fe736e8a91ee2270ab43bf46409889ba90c3e509
    HEAD_REF main
)

set(ENV{SETUPTOOLS_SCM_PRETEND_VERSION} "${VERSION}")
vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -x)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
