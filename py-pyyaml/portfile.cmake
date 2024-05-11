vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    PyYAML
    VERSION         ${VERSION}
    SHA512          94a29924484f557c0966d485c2b70232909253f27fcea9b89e1db1462abf61f2f85d55fbae0177b2bed70eb5daa75813551e868df4df4cddfdee9a87bd08485f
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -x)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
