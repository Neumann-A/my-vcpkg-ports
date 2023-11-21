vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python-jsonschema/referencing
    REF v${VERSION}
    SHA512 185847a1966c312b947efe80642db0b92d7723375ef6e19551bc50c5e9b5fa3a01ac949c6b6f063ce817b6de6b4d1d8997f78f4125abe2f12d0302e2282c1cb5
    HEAD_REF main
)

set(ENV{SETUPTOOLS_SCM_PRETEND_VERSION} "${VERSION}")
pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -x)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
