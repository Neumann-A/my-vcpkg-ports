vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO huggingface/transformers
    REF v${VERSION}
    SHA512 3cca2fc566f89015ceb6b8e76e887b110ad20e00db7b1555df711df2a5cfc361725746386dbfb0556f1a9ed3a523e72f93ff5d08413219a94c6539ef784997c7
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
