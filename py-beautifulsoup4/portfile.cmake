vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    beautifulsoup4
    VERSION         ${VERSION}
    SHA512          b5b6cc9f64a97fa52b9a2ee1265aa215db476e705d3d79e49301de7e8d36c56c96924cb440eec0715f7ec75c5ddf4c1ade9d6cef7cdc9bf9e37125ac6eb50837
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "bs4")
