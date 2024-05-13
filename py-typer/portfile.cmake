vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO tiangolo/typer
    REF ${VERSION}
    SHA512 a779680b97d971a140f1db11f2d0c53bfeb10dcfa278f8a849da14a9c36a7341ffc51367ef12ecbe9d71fc398f5fdf6e1c6f1ca09f2ed959766d8e3032f5744e
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(USE_BUILD SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "typer")
