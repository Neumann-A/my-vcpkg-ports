
# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
if(_IMPORT_PREFIX STREQUAL "/")
  set(_IMPORT_PREFIX "")
endif()

find_dependency(Qt6 COMPONENTS Svg Widgets Gui Concurrent PrintSupport OpenGL)

add_library(qwt::qwt UNKNOWN IMPORTED)

set_target_properties(qwt::qwt PROPERTIES
  COMPATIBLE_INTERFACE_STRING "QT_MAJOR_VERSION;QT_COORD_TYPE"
  INTERFACE_COMPILE_DEFINITIONS ""
  INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
  INTERFACE_LINK_LIBRARIES "Qt6::Gui;Qt6::Svg;Qt6::Widgets;Qt6::Concurrent;Qt6::PrintSupport;Qt6::OpenGL"
)

find_library(QWT_RELEASE NAMES qwt PATHS "${_IMPORT_PREFIX}/lib" NO_DEFAULT_PATHS)
set_property(TARGET qwt::qwt APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(qwt::qwt PROPERTIES
    IMPORTED_LOCATION_RELEASE "${QWT_RELEASE}"
)

if(NOT "@VCPKG_BUILD_TYPE@")
    find_library(QWT_DEBUG NAMES qwt qwtd qwt_debug PATHS "${_IMPORT_PREFIX}/debug/lib" NO_DEFAULT_PATHS)
    set_property(TARGET qwt::qwt APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
    set_target_properties(qwt::qwt PROPERTIES
      IMPORTED_LOCATION_DEBUG "${QWT_DEBUG}"
    )
endif()