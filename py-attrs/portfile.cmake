vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python-attrs/attrs
    REF ${VERSION}
    SHA512 e96727d68081a761effcdf5a5d62d66902e7f5229879711739fd14d257b7f1c71ddab84309ffeff161bfc4da3a2b130eda4fad920b9f5bc3134bed138d05c16c
    HEAD_REF main
)

set(ENV{SETUPTOOLS_SCM_PRETEND_VERSION} "${VERSION}")
vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -x)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
