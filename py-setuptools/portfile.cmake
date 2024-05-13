vcpkg_from_pythonhosted(
    OUT_SOURCE_PATH SOURCE_PATH
    PACKAGE_NAME    setuptools
    VERSION         ${VERSION}
    SHA512          81f4a5184976a0d4aa070261bb56458c54ec6a479786fa469e98cb336e9a1691b281ae771abe41bc5398fac15b2dd039c07cf014ee00572f46908ce6830fcb6a
    PATCHES 
      fix-prefix.patch
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
#execute_process(COMMAND ${PYTHON3} "${SOURCE_PATH}/setup.py" install "--prefix=${CURRENT_INSTALLED_DIR}/tools/python3" "--root=${CURRENT_PACKAGES_DIR}"
#  COMMAND_ERROR_IS_FATAL ANY
#  WORKING_DIRECTORY  "${CURRENT_PACKAGES_DIR}/tools/python3"
#)
vcpkg_python_test_import(MODULE "setuptools")
