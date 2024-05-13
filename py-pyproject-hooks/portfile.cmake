vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pypa/pyproject-hooks
    REF v${VERSION}
    SHA512 256028d13adbe35126a63431a2a49e0c48adddce5ffc3ff2eebad368eee7ce52591ecfd8a8526876de20bc59dfc87156533d6a97b55538a739873e60f9509eff
    HEAD_REF main
)

file(COPY "${SOURCE_PATH}/src/pyproject_hooks" DESTINATION "${CURRENT_PACKAGES_DIR}/${PYTHON3_SITE}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

#vcpkg_python_test_import(MODULE "pyproject-hooks")
