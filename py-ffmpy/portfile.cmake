vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Ch00k/ffmpy
    REF ${VERSION}
    SHA512 097d1e435b3b6598c95e69e517aaa12a8d5e92bbc988deb00793ddbd7262367891e212a02c5036417ceaae0b6661938b0f1cf28022803f3ec4e395976b31e3bd
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "ffmpy")
