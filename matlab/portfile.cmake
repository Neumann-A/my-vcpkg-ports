SET(VCPKG_POLICY_EMPTY_PACKAGE enabled)


#COMPONENTS: MAIN_PROGRAM MAT_LIBRARY ENG_LIBRARY MEX_COMPILER 

# Make sure MATLAB can be found
vcpkg_configure_cmake(SOURCE_PATH ${CMAKE_CURRENT_LIST_DIR}
                      OPTIONS 
                      --trace-expand
                      "-DMatlab_MAIN_PROGRAM=-NOTFOUND"
                      "-D_matlab_main_tmp=-NOTFOUND"
                      "-DCOMPONENTS=${COMPONENTS}")