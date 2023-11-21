vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python-jsonschema/jsonschema
    REF v${VERSION}
    SHA512 03619b7823c15edee02a9d282d2f19bc8798e4a41210c4ff145f5e608e85219d7cf264c400bbe3fe97b5ab88967c15a9c63acaca39c2a692127a95722119d0e8
    HEAD_REF master
)

set(ENV{SETUPTOOLS_SCM_PRETEND_VERSION} "${VERSION}")
pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -x)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
