vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO tiangolo/fastapi
    REF ${VERSION}
    SHA512 3b613e4b2e7253fa08c09f961e69d384d2f44d07dc7f045b669c3e78f21a161715f3e9a0cb813a1c6e793f4a322160ec3eeb4eef90ba59db64bde9baaa539c13
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(USE_BUILD SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "fastapi")
