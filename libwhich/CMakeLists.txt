cmake_minimum_required(VERSION 3.25)

project(libwhich)
include(GNUInstallDirs)

#set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
add_executable(libwhich libwhich.c)

install(TARGETS libwhich
        RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
)