vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jupyter/notebook
    REF 28a68707d669e0ebfd573133eae19d7f2a2a74c7
    SHA512 6045daa50f26f73a33dc8e98133c5165ca0fecbe409e3819f11f24ca86425765b9fa91f5b9ec8a4efe8b44be45dd9cf832ee35ed003ed518283c96b86c0f1ce4
    HEAD_REF main
)

#jupyter_packaging~=0.9, nbclassic>=0.4.0

set(PYTHON3 "${CURRENT_INSTALLED_DIR}/tools/python3/python.exe")

set(wheeldir "${CURRENT_PACKAGES_DIR}/wheels")

file(MAKE_DIRECTORY "${wheeldir}")

execute_process(COMMAND ${PYTHON3} -m build -w -o "${wheeldir}" "${SOURCE_PATH}"
  COMMAND_ERROR_IS_FATAL ANY
  #WORKING_DIRECTORY  "${wheeldir}"
)

file(GLOB WHEEL "${wheeldir}/*.whl")

execute_process(COMMAND ${PYTHON3} -m installer  --prefix "${CURRENT_INSTALLED_DIR}/tools/python3" --destdir "${CURRENT_PACKAGES_DIR}" "${WHEEL}"
  COMMAND_ERROR_IS_FATAL ANY
  ##WORKING_DIRECTORY  "${wheeldir}"
)

cmake_path(GET CURRENT_INSTALLED_DIR ROOT_NAME rootName)
string(REPLACE "${rootName}/" "/" without_drive_letter_installed ${CURRENT_INSTALLED_DIR})

file(RENAME "${CURRENT_PACKAGES_DIR}${without_drive_letter_installed}/tools" "${CURRENT_PACKAGES_DIR}/tools")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/all")

#execute_process(COMMAND ${PYTHON3} ${SOURCE_PATH}/setup.py -q bdist_wheel -d "${CURRENT_PACKAGES_DIR}/tools/python3/wheels"
#  COMMAND_ERROR_IS_FATAL ANY
#)
#execute_process(COMMAND ${Python_EXECUTABLE} -m pip install -v ${CMAKE_BINARY_DIR}/python/lib --prefix=${CMAKE_INSTALL_PREFIX} --root=\$ENV{DESTDIR})

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)