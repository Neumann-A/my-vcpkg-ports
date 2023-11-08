vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO abetlen/llama-cpp-python
    REF v${VERSION}
    SHA512 e41a9a0bb759182b31820314aa5a3ba83f35731aabf40184218ed1a850304ae1339c447925290b5c83ef254a8d8b2ff8e933aee7f1b5745075015daf03f7f479
    HEAD_REF main
)

file(COPY "${SOURCE_PATH}/llama_cpp" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")
