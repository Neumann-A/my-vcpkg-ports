vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    PyQt-builder
    VERSION         ${VERSION}
    SHA512          ec0b9f7784a32af744111615b93f98d73f284bb752fd71359c798d3b093a01925823effea72c866a5f49f77e3dfc5dee4125bbb289f647d84000bf34b5db6931
    PATCHES
      libpath.patch
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

# Shiver ... where do they come from
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/${python_versioned}/site-packages/pyqtbuild/bundle/dlls/)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_python_test_import(MODULE "pyqtbuild")
