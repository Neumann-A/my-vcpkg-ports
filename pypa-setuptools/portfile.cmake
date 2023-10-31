vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pypa/setuptools
    REF 49fec9fafb0e23e0dde52d3c4c410d23a2de9b0d
    SHA512 2c80bbb701ef2a4d6b72db4fbbbd32e62c8d27862efeee8da7ee8f148df9b2d837d8ebc84cede92a6ccdda7911f37417392bf6f43823110012711f7c067f7291
    HEAD_REF main
    PATCHES 
      fix-prefix.patch
)

pypa_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
#execute_process(COMMAND ${PYTHON3} "${SOURCE_PATH}/setup.py" install "--prefix=${CURRENT_INSTALLED_DIR}/tools/python3" "--root=${CURRENT_PACKAGES_DIR}"
#  COMMAND_ERROR_IS_FATAL ANY
#  WORKING_DIRECTORY  "${CURRENT_PACKAGES_DIR}/tools/python3"
#)