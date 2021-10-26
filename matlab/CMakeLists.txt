cmake_minimum_required(VERSION 3.19)

if(NOT COMPONENTS)
    set(COMPONENTS MAT_LIBRARY)
endif()

project(MATLAB-find-package)
set(MATLAB_FIND_DEBUG)
find_package(Matlab 9.11 COMPONENTS ${COMPONENTS} REQUIRED)
