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
set(MEMTAILOR_FOUND FALSE)
if(TARGET memtailor::memtailor)
  set(MEMTAILOR_FOUND TRUE)
  set(MEMTAILOR_LIBRARIES memtailor::memtailor)
endif()
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Memtailor DEFAULT_MSG MEMTAILOR_FOUND)
