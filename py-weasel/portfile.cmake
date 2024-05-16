vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO explosion/weasel
    REF v${VERSION}
    SHA512 e1fbb213902deb45bd420f16eacfe5690bde6fa276ea3921c6154da59ff011f20b4a71e9540df9b9d5b1d94430ab9e0c8b718e9782576c2c83e6d8eb465c8282
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "weasel")
