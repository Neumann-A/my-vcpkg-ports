vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO encode/starlette
    REF ${VERSION}
    SHA512 27240c706553e610da05cfc92f818c61e97a891ea7c960fef925a122100a61931cbca973a0995aa1e79d192cda2250139f471929a3f4a7b0f4600d00b6287744
    HEAD_REF master
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "starlette")
