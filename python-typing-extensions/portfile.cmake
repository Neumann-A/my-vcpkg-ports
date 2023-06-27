vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python/typing_extensions
    REF c57333b77603298e2d79fdaf7632e09e40d11f54
    SHA512 ac8f53a32e4af91a95a50933f0889c401098216a588b2fe555ab0fe73988e893c9171614a4dc11412bbd10b19012388abd3beae645ce4c2bd49805f2b90f9d90
    HEAD_REF main
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

