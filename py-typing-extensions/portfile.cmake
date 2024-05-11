vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO python/typing_extensions
    REF ${VERSION}
    SHA512 1e82f49d837c3fbead7d0867db667f97be2836f1f98bcde7315eb8c5455e605659fe7759ccf86fcbb2373789d9dab500a3b2a75bbcaf9216521c6b8c2796090a
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
