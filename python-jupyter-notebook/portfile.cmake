vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jupyter/notebook
    REF 28a68707d669e0ebfd573133eae19d7f2a2a74c7
    SHA512 0
    HEAD_REF main
)

set(PYTHON3 "${CURRENT_INSTALLED_DIR}/tools/python3/python.exe")

execute_process(COMMAND ${PYTHON3} ${SOURCE_PATH}/setup.py -q bdist_wheel -d "${CURRENT_PACKAGES_DIR}/tools/python3/wheels")