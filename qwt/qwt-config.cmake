find_dependency(Qt6 COMPONENTS Svg Widgets Gui Concurrent PrintSupport OpenGL)

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" DIRECTORY)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" DIRECTORY)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" DIRECTORY)
if(_IMPORT_PREFIX STREQUAL "/")
  set(_IMPORT_PREFIX "")
endif()

set(qwt_INCLUDE_DIR "${_IMPORT_PREFIX}/include")
find_library(qwt_LIBRARY_RELEASE NAMES qwt NAMES_PER_DIR PATHS "${_IMPORT_PREFIX}/lib" NO_DEFAULT_PATHS)
find_library(qwt_LIBRARY_DEBUG NAMES qwtd qwt_debug qwt NAMES_PER_DIR PATHS "${_IMPORT_PREFIX}/debug/lib" NO_DEFAULT_PATHS)
select_library_configurations(qwt)

if(NOT EXISTS "${qwt_INCLUDE_DIR}")
  message(FATAL_ERROR "qwt include dir not existing! qwt_INCLUDE_DIR: ${qwt_INCLUDE_DIR}; CMAKE_CURRENT_LIST_FILE:${CMAKE_CURRENT_LIST_FILE}")
endif()
if(NOT TARGET qwt::qwt)
  add_library(qwt::qwt UNKNOWN IMPORTED)
  set_target_properties(qwt::qwt PROPERTIES
    INTERFACE_COMPILE_DEFINITIONS ""
    INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
    INTERFACE_LINK_LIBRARIES "Qt6::Gui;Qt6::Svg;Qt6::Widgets;Qt6::Concurrent;Qt6::PrintSupport;Qt6::OpenGL"
  )
  if(qwt_LIBRARY_RELEASE)
      set_property(TARGET qwt::qwt APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
      set_target_properties(qwt::qwt PROPERTIES
          IMPORTED_LOCATION_RELEASE "${qwt_LIBRARY_RELEASE}"
      )
  endif()
  if(qwt_LIBRARY_DEBUG)
      set_property(TARGET qwt::qwt APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
      set_target_properties(qwt::qwt PROPERTIES
        IMPORTED_LOCATION_DEBUG "${qwt_LIBRARY_DEBUG}"
      )
  endif()
endif()

if(qwt_LIBRARIES AND qwt_INCLUDE_DIR)
  set(qwt_FOUND TRUE)
  set(QWT_FOUND TRUE)
  set(Qwt_FOUND TRUE)
else()
  set(qwt_FOUND FALSE)
  set(QWT_FOUND FALSE)
  set(Qwt_FOUND FALSE)
endif()

