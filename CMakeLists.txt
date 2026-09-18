cmake_minimum_required(VERSION 3.18)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(mathic VERSION 1.5 LANGUAGES CXX)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)
include(CTest)

option(enable_pqsim "Build pqsim" OFF)
option(enable_divsim "Build divsim" OFF)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

find_package(Threads REQUIRED QUIET)
find_package(Memtailor REQUIRED)
add_library(memtailor ALIAS memtailor::memtailor)

add_compile_options(
  -DPACKAGE_NAME="${PROJECT_NAME}"
  -DPACKAGE_TARNAME="${PROJECT_NAME}"
  -DPACKAGE_VERSION="${PROJECT_VERSION}"
  -DPACKAGE_STRING="${PROJECT_NAME} ${PROJECT_VERSION}"
  -DPACKAGE_BUGREPORT=""
  -DPACKAGE_URL=""
  -DPACKAGE="${PROJECT_NAME}"
  -Wall -Wextra -Wno-unused-parameter
  )

add_subdirectory(src)

set_target_properties(mathic PROPERTIES
  VERSION 0.0.5 SOVERSION 0 PUBLIC_HEADER src/mathic.h)
install(TARGETS mathic EXPORT mathicTargets
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(DIRECTORY src/mathic DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  FILES_MATCHING PATTERN "*.h")
install(FILES README.md lgpl-2.0.txt lgpl-2.1.txt lgpl-3.0.txt DESTINATION ${CMAKE_INSTALL_DOCDIR})

set(mathic_cmakedir "${CMAKE_INSTALL_LIBDIR}/cmake/mathic")
configure_package_config_file(cmake/mathicConfig.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/mathicConfig.cmake.in"
  INSTALL_DESTINATION "${mathic_cmakedir}")
file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/mathicConfig.cmake"
  INPUT "${CMAKE_CURRENT_BINARY_DIR}/mathicConfig.cmake.in")
write_basic_package_version_file("${CMAKE_CURRENT_BINARY_DIR}/mathicConfigVersion.cmake"
  VERSION ${PROJECT_VERSION} COMPATIBILITY SameMajorVersion)
install(FILES cmake/FindMemtailor.cmake DESTINATION "${mathic_cmakedir}")
install(EXPORT mathicTargets NAMESPACE mathic:: DESTINATION "${mathic_cmakedir}")
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/mathicConfig.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/mathicConfigVersion.cmake" DESTINATION "${mathic_cmakedir}")
configure_file(cmake/mathic.pc.in mathic.pc.in @ONLY)
file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/mathic.pc"
  INPUT "${CMAKE_CURRENT_BINARY_DIR}/mathic.pc.in")
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/mathic.pc"
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)

if(enable_pqsim)
add_executable(pqsim
  src/pqsim/pqMain.h         src/pqsim/pqMain.cpp
  src/pqsim/Item.h           src/pqsim/Item.cpp
  src/pqsim/Model.h          src/pqsim/Model.cpp
  src/pqsim/Simulator.h      src/pqsim/Simulator.cpp
  src/pqsim/GeobucketModel.h
  src/pqsim/HeapModel.h
  src/pqsim/StlSetModel.h
  src/pqsim/TourTreeModel.h
  src/pqsim/stdinc.h
  )
target_link_libraries(pqsim mathic)
endif()

if(enable_divsim)
add_executable(divsim
  src/divsim/divMain.h       src/divsim/divMain.cpp 
  src/divsim/Simulation.h    src/divsim/Simulation.cpp
  src/divsim/DivListModel.h
  src/divsim/KDTreeModel.h
  src/divsim/Monomial.h
  src/divsim/stdinc.h
  )
target_link_libraries(divsim mathic)
endif()
