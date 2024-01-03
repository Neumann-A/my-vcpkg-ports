vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pypa/setuptools
    REF v${VERSION}
    SHA512 93cea3b30093ff0094acdcc688e689dcf7173e43cfd33bf3bc2e268f7f5065e38627f942f6778d29fd10d2e467af28b0d772bf2fc94318e3e74670d1d5f3e4ea
    HEAD_REF main
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