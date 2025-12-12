cmake_minimum_required(VERSION 3.12)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(mathic VERSION 1.1 LANGUAGES CXX)

option(enable_pqsim "Build pqsim" OFF)
option(enable_divsim "Build divsim" OFF)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

find_package(Threads 2.1 REQUIRED QUIET)
find_package(Memtailor   REQUIRED)

add_library(memtailor STATIC IMPORTED)
set_target_properties(memtailor PROPERTIES
  IMPORTED_LOCATION             "${MEMTAILOR_LIBRARIES}"
  INTERFACE_INCLUDE_DIRECTORIES "${MEMTAILOR_INCLUDE_DIR}")

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

set_target_properties(mathic PROPERTIES PUBLIC_HEADER src/mathic.h)

install(TARGETS mathic LIBRARY DESTINATION lib)
install(DIRECTORY src/mathic
  DESTINATION include
  FILES_MATCHING PATTERN "*.h"
  )
install(FILES README.md lgpl-2.0.txt lgpl-2.1.txt lgpl-3.0.txt
  DESTINATION licenses/mathic
  )

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
