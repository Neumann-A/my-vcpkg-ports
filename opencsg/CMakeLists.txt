cmake_minimum_required (VERSION 3.4)
project (opencsg)

set(HEADERS
  include/opencsg.h
)

file(GLOB_RECURSE SRCS "src/*.cpp")#  "src/glad/src*.cpp")

add_library(opencsg ${SRCS} ${HEADERS})

include_directories(src include RenderTexture ".")
find_package(GLEW REQUIRED)
include_directories(${GLEW_INCLUDE_DIRS})
target_link_libraries(opencsg PRIVATE GLEW::GLEW)

install(
  TARGETS opencsg
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

if(NOT DISABLE_INSTALL_HEADERS)
	install(FILES ${HEADERS} DESTINATION include/opencsg)
endif()
