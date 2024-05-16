vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python-jsonschema/jsonschema-specifications
    REF v${VERSION}
    SHA512 2731562df17e09858da29eadaac6ed60e8ee981e57efd74c2ec361241ccd45ade6bb5b7490a197668231a58206232e7a09132fe8932cf190ef4a124aa65db470
    HEAD_REF main

)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "jsonschema_specifications")
