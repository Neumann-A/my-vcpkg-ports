#PYTHON_EXECUTABLE "${CURRENT_INSTALLED_DIR}/tools/python3/python.exe" 
x_vcpkg_get_python_packages(PYTHON_VERSION "3" OUT_PYTHON_VAR "PYTHON3" PACKAGES notebook metakernel)

#file(COPY "${CURRENT_INSTALLED_DIR}/tools/python3/Scripts/" DESTINATION "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-venv/Lib")

file(COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-venv/" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/root/jupyter")