# Try to find the MEMTAILOR libraries
# See https://github.com/Macaulay2/memtailor
#
# This file sets up MEMTAILOR for CMake. Once done this will define
#  MEMTAILOR_FOUND             - system has MEMTAILOR lib
#  MEMTAILOR_INCLUDE_DIR       - the MEMTAILOR include directory
#  MEMTAILOR_LIBRARIES         - Libraries needed to use MEMTAILOR
#  memtailor::memtailor        - imported target, with memtailor's ABI flags
#
# Copyright (c) 2020, Mahrud Sayrafi, <mahrud@umn.edu>
#
# Redistribution and use is allowed according to the terms of the BSD license.

# Prefer memtailor's CMake config, then pkg-config; both record MEMT_DEBUG.
find_package(memtailor CONFIG QUIET)
if(TARGET memtailor::memtailor)
  get_target_property(MEMTAILOR_INCLUDE_DIR memtailor::memtailor
    INTERFACE_INCLUDE_DIRECTORIES)
  set(MEMTAILOR_LIBRARIES memtailor::memtailor)
else()
  find_package(PkgConfig QUIET)
  if(PKG_CONFIG_FOUND)
    pkg_check_modules(PC_MEMTAILOR QUIET memtailor)
  endif()

  find_path(MEMTAILOR_INCLUDE_DIR NAMES memtailor.h
    HINTS ${PC_MEMTAILOR_INCLUDE_DIRS}
    PATHS ${INCLUDE_INSTALL_DIR} ${CMAKE_INSTALL_PREFIX}/include
    PATH_SUFFIXES memtailor
    )
  find_library(MEMTAILOR_LIBRARIES NAMES memtailor
    HINTS ${PC_MEMTAILOR_LIBRARY_DIRS}
    PATHS ${LIB_INSTALL_DIR} ${CMAKE_INSTALL_PREFIX}/lib
    )
endif()

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Memtailor DEFAULT_MSG MEMTAILOR_INCLUDE_DIR MEMTAILOR_LIBRARIES)

mark_as_advanced(MEMTAILOR_INCLUDE_DIR MEMTAILOR_LIBRARIES)

if(MEMTAILOR_FOUND AND NOT TARGET memtailor::memtailor)
  add_library(memtailor::memtailor UNKNOWN IMPORTED)
  set_target_properties(memtailor::memtailor PROPERTIES
    IMPORTED_LOCATION "${MEMTAILOR_LIBRARIES}"
    INTERFACE_INCLUDE_DIRECTORIES "${MEMTAILOR_INCLUDE_DIR}"
    INTERFACE_COMPILE_OPTIONS "${PC_MEMTAILOR_CFLAGS_OTHER}")
endif()
