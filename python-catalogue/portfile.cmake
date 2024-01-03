vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/catalogue
    REF v${VERSION}
    SHA512 2181e5485f398c0db68534f04e77d198753f1f5c543c28432865f954ffa1181f786cf1ba498ab9db8d22268f1847fe047a66617b0ed1868fc13db34f694528a8
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
