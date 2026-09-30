# Prefer the upstream config; pkg-config also carries the dependency's ABI flags.
# Copyright (c) 2020, Mahrud Sayrafi, <mahrud@umn.edu>
# Redistribution and use is allowed according to the terms of the BSD license.
if(NOT TARGET memtailor::memtailor)
  find_package(memtailor CONFIG QUIET)
endif()
if(NOT TARGET memtailor::memtailor)
  find_package(PkgConfig QUIET)
  if(PKG_CONFIG_FOUND)
    pkg_check_modules(MEMTAILOR QUIET IMPORTED_TARGET memtailor)
    if(TARGET PkgConfig::MEMTAILOR)
      add_library(memtailor::memtailor INTERFACE IMPORTED)
      set_property(TARGET memtailor::memtailor PROPERTY
        INTERFACE_LINK_LIBRARIES PkgConfig::MEMTAILOR)
    endif()
  endif()
endif()
# Older installations may provide only headers and a library.
if(NOT TARGET memtailor::memtailor)
  find_path(MEMTAILOR_INCLUDE_DIR NAMES memtailor.h
    PATHS ${INCLUDE_INSTALL_DIR} ${CMAKE_INSTALL_PREFIX}/include
    PATH_SUFFIXES memtailor)
  find_library(MEMTAILOR_LIBRARY NAMES memtailor
    PATHS ${LIB_INSTALL_DIR} ${CMAKE_INSTALL_PREFIX}/lib)
  if(MEMTAILOR_INCLUDE_DIR AND MEMTAILOR_LIBRARY)
    add_library(memtailor::memtailor UNKNOWN IMPORTED)
    set_target_properties(memtailor::memtailor PROPERTIES
      IMPORTED_LOCATION "${MEMTAILOR_LIBRARY}"
      INTERFACE_INCLUDE_DIRECTORIES "${MEMTAILOR_INCLUDE_DIR}")
  endif()
  mark_as_advanced(MEMTAILOR_INCLUDE_DIR MEMTAILOR_LIBRARY)
endif()
set(MEMTAILOR_FOUND FALSE)
if(TARGET memtailor::memtailor)
  set(MEMTAILOR_FOUND TRUE)
  set(MEMTAILOR_LIBRARIES memtailor::memtailor)
endif()
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Memtailor DEFAULT_MSG MEMTAILOR_FOUND)
