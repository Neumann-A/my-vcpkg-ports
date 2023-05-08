cmake_minimum_required(VERSION 3.25)

project(dSFMT)
include(GNUInstallDirs)

set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
add_library(dSFMT dSFMT.c)

if(CMAKE_SYSTEM_PROCESSOR MATCHES "(AMD64|x86_x64)")
    add_compile_definitions(HAVE_SSE2)
endif()

set(headers 
        dSFMT.h
        dSFMT-common.h
        dSFMT-params.h
        dSFMT-params521.h
        dSFMT-params1279.h
        dSFMT-params2203.h
        dSFMT-params4253.h
        dSFMT-params11213.h
        dSFMT-params19937.h
)

set_target_properties(dSFMT PROPERTIES PUBLIC_HEADER "${headers}")

install(TARGETS dSFMT
        ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
        PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)