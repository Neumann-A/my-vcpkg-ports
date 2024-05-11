vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO FFY00/python-pyproject-metadata
    REF ${VERSION}
    SHA512 a4cb97b6646b765016f047f8d3da388ab758dbf8acf5a8ee6ccb017c764a90c069e04effbef21f878be7f4b01a5090f24252372300ce7e3a0410a6eea5d98b66
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
