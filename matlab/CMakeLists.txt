cmake_minimum_required(VERSION 3.19)

if(NOT COMPONENTS)
    set(COMPONENTS MAT_LIBRARY)
endif()

project(MATLAB-find-package)
set(MATLAB_FIND_DEBUG)
find_package(MATLAB COMPONENTS ${COMPONENTS} REQUIRED)
