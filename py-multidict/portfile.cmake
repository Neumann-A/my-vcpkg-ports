vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO aio-libs/multidict
    REF v${VERSION}
    SHA512 500d3b2a139d40442462a2b49f9dd0c01631643ef9905367d8b7c472a1030437c26a042a28e11ba94058a17821628d96f19ec6ca479d5831e2f1263ff0069871
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "multidict")
