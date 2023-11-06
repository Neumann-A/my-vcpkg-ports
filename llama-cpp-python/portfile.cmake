vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO abetlen/llama-cpp-python
    REF v${VERSION}
    SHA512 0
    HEAD_REF main
)

file(COPY "${SOURCE_PATH}/llama_cpp" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
