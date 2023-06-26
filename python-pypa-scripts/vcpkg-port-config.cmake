include_guard(GLOBAL)

set(PYTHON3_BASEDIR "${CURRENT_INSTALLED_DIR}/tools/python3")
set(PYTHON3 "${PYTHON3_BASEDIR}/python.exe")
set(PYTHON3_SITEPACKAGES "${PYTHON3_BASEDIR}/Lib/site-packages")

include("${CMAKE_CURRENT_LIST_DIR}/pypa_python_functions.cmake")
