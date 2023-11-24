vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO abetlen/llama-cpp-python
    REF v${VERSION}
    SHA512 32bb4d046ec1ebabcdfd24b868aebbd8ab9d542dccb9e8a6bf220d302da97fc9739cc9af71667c30277dadcabfde990738d4362fe029a5edbb5967e40e2781da
    HEAD_REF main
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

#file(COPY "${SOURCE_PATH}/llama_cpp" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/python3/Lib/site-packages")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")
