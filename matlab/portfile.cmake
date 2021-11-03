SET(VCPKG_POLICY_EMPTY_PACKAGE enabled)

#COMPONENTS: MAIN_PROGRAM MAT_LIBRARY ENG_LIBRARY MEX_COMPILER 

# Make sure MATLAB can be found
vcpkg_configure_cmake(SOURCE_PATH "${CMAKE_CURRENT_LIST_DIR}"
                      OPTIONS 
                      --trace-expand
                      "-D_matlab_main_tmp=-NOTFOUND"
                      "-DCOMPONENTS=${COMPONENTS}")

file(COPY "${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(COPY "${CMAKE_CURRENT_LIST_DIR}/FindMatlab.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")