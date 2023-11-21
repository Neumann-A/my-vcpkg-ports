vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Ch00k/ffmpy
    REF ${VERSION}
    SHA512 b265ff795bc52244d3104fc39301254927b3ee33cd28e5de2aeee8a1f2b4e278272ab35092bb9ada2b213cea32a62e7e3552b5856cb8e49c9682722c6bdbbdfb
    HEAD_REF master
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
