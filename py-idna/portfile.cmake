vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO kjd/idna
    REF v${VERSION}
    SHA512 f753f37ae58fdb7b776c37757f7827c874eb13535db6427bc2a724e7ff1e28c2e3eb287a13eb97c37ee588d2c5217fe592f64ec305b122726ef5576c5317a34b
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "idna")
