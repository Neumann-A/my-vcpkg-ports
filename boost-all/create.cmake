# Set boost version.
set(BOOST_VERSION 1.73.0)

# Set vcpkg root directory.
find_program(VCPKG NAMES vcpkg)
if(NOT VCPKG_ROOT)
  if(DEFINED ENV{VCPKG_ROOT})
    set(VCPKG_ROOT "$ENV{VCPKG_ROOT}" CACHE STRING "")
  else()
    if(NOT VCPKG)
      message(FATAL_ERROR "Could not find program: vcpkg")
    endif()
    get_filename_component(VCPKG_ROOT ${VCPKG} DIRECTORY)
  endif()
endif()

# Set boost ports directory.
set(BOOST_PORTS_DIR ${CMAKE_CURRENT_LIST_DIR}/ports)

# Remove ports created for old version.
file(GLOB BOOST_PORTS_OLD ${BOOST_PORTS_DIR}/boost-*)
foreach(PORT_OLD ${BOOST_PORTS_OLD})
  get_filename_component(PORT ${PORT_OLD} NAME)
  file(REMOVE_RECURSE ${BOOST_PORTS_DIR}/${PORT})
endforeach()

# Create ports for all boost subprojects.
set(BOOST_BUILD_DEPENDS "")
file(GLOB BOOST_PORTS ${VCPKG_ROOT}/ports/boost-*)
foreach(PORT_SRC ${BOOST_PORTS})
  get_filename_component(PORT ${PORT_SRC} NAME)
  string(REGEX REPLACE "^boost-" "" NAME ${PORT})
  string(REPLACE "-" " " NAME ${NAME})
  file(MAKE_DIRECTORY ${BOOST_PORTS_DIR}/${PORT})
  file(WRITE  ${BOOST_PORTS_DIR}/${PORT}/CONTROL "Source: ${PORT}\n")
  file(APPEND ${BOOST_PORTS_DIR}/${PORT}/CONTROL "Version: ${BOOST_VERSION}\n")
  file(APPEND ${BOOST_PORTS_DIR}/${PORT}/CONTROL "Homepage: https://boost.org\n")
  file(APPEND ${BOOST_PORTS_DIR}/${PORT}/CONTROL "Description: Boost ${NAME} module\n")
  file(WRITE  ${BOOST_PORTS_DIR}/${PORT}/portfile.cmake "set(VCPKG_POLICY_EMPTY_PACKAGE enabled)\n")
  if(BOOST_BUILD_DEPENDS STREQUAL "")
    set(BOOST_BUILD_DEPENDS "${PORT}")
  else()
    string(APPEND BOOST_BUILD_DEPENDS ", ${PORT}")
  endif()
endforeach()

# Create CONTROL file.
file(WRITE ${BOOST_PORTS_DIR}/boost/CONTROL "\
Source: boost
Version: ${BOOST_VERSION}
Homepage: https://boost.org
Description: Peer-reviewed portable C++ source libraries
Build-Depends: ${BOOST_BUILD_DEPENDS}
Default-Features: bzip2, lzma, zlib, zstd

Feature: bzip2
Description: Build boost with bzip2 support.
Build-Depends: bzip2

Feature: lzma
Description: Build boost with lzma support.
Build-Depends: liblzma

Feature: zlib
Description: Build boost with zlib support.
Build-Depends: zlib

Feature: zstd
Description: Build boost with zstd support.
Build-Depends: zstd\n")

# Report success.
set(REPORT_COMMAND "vcpkg install --vcpkg-root \"${VCPKG_ROOT}\"")
if(VCPKG)
  get_filename_component(VCPKG_BASE ${VCPKG} DIRECTORY)
  get_filename_component(VCPKG_BASE_ABSOLUTE ${VCPKG_BASE} ABSOLUTE)
  get_filename_component(VCPKG_ROOT_ABSOLUTE ${VCPKG_ROOT} ABSOLUTE)
  if(VCPKG_BASE_ABSOLUTE STREQUAL VCPKG_ROOT_ABSOLUTE)
    set(REPORT_COMMAND "vcpkg install")
  endif()
endif()

if(CMAKE_CURRENT_LIST_DIR MATCHES " ")
  string(APPEND REPORT_COMMAND " --overlay-ports=\"${BOOST_PORTS_DIR}\" boost")
else()
  string(APPEND REPORT_COMMAND " --overlay-ports=${BOOST_PORTS_DIR} boost")
endif()

message("Success. Install the boost port using vcpkg overlays.\n${REPORT_COMMAND}")
