vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pypa/hatch
    REF hatchling-v${VERSION}
    SHA512 e71e51fdace9b9aa276c2efba3a81a030ed934c21283057f83a6ce4a09f8feed8cd4386088280c9fe1381dd92e574daeda8c845a6a2cf6a015708126ca9788d7
    HEAD_REF master
)


vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}/backend")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
