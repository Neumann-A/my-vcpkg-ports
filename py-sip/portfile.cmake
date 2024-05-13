vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    sip
    VERSION         ${VERSION}
    SHA512          885c32a051e882b82b59bf1365050933f8fc1c619b19f4bc03235edc5741a5e14aae8edf90479ad0283f74ba5c5233a2589c151ec865b130199a6db9800a2294
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

# Shiver ... where do they come from
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/${python_versioned}/site-packages/pyqtbuild/bundle/dlls/)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "sipbuild")
