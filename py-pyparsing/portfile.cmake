vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pyparsing/pyparsing
    REF ${VERSION}
    SHA512 172f0186b1748341c591c92f805f2944be309b39217d930ae32b519488813d9012cd993d15f6d6757fb280cb35a7abd77923f1f1e8a3b54a3ed3bdbb149ac56c
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "pyparsing")
