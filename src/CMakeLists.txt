if(CMAKE_BUILD_TYPE STREQUAL Debug)
  add_compile_options(-DMATHIC_DEBUG -DMEMT_DEBUG)
endif()

add_library(mathic
  mathic.h
  mathic.cpp
  mathic/Action.cpp
  mathic/Action.h
  mathic/BinaryKDTree.h
  mathic/BitTriangle.cpp
  mathic/BitTriangle.h
  mathic/BoolParameter.cpp
  mathic/BoolParameter.h
  mathic/CliParameter.cpp
  mathic/CliParameter.h
  mathic/CliParser.cpp
  mathic/CliParser.h
  mathic/ColumnPrinter.cpp
  mathic/ColumnPrinter.h
  mathic/DivMask.cpp
  mathic/DivMask.h
  mathic/HelpAction.cpp
  mathic/HelpAction.h
  mathic/IntegerParameter.cpp
  mathic/IntegerParameter.h
  mathic/StringParameter.cpp
  mathic/StringParameter.h
  mathic/Timer.cpp
  mathic/Timer.h
  mathic/display.cpp
  mathic/display.h
  mathic/error.cpp
  mathic/error.h
  mathic/stdinc.h
  )

target_link_libraries(mathic memtailor Threads::Threads)

target_include_directories(mathic PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
  $<INSTALL_INTERFACE:include>
  )

include(CTest)
if(BUILD_TESTING)
  add_executable(mathic-unit-tests
    test/BitTriangle.cpp
    test/DivFinder.cpp
    test/HashTable.cpp
    test/PairQueue.cpp
    test/testMain.cpp
    )

  ################################
  # add gtest testing ############
  ################################
  if(NOT GTEST_FOUND)
    find_package(GTest)
  endif()
  include(GoogleTest)
  gtest_discover_tests(mathic-unit-tests TEST_PREFIX unit-tests:)

  if(GTEST_FOUND)
    target_link_libraries(mathic-unit-tests mathic GTest::GTest GTest::Main)
  else()
    include(FetchContent)
    FetchContent_Declare(googletest
      GIT_REPOSITORY https://github.com/google/googletest.git
      GIT_TAG        v1.16.0
      )
    FetchContent_MakeAvailable(googletest)

    target_link_libraries(mathic-unit-tests mathic gtest)
    target_include_directories(mathic-unit-tests PRIVATE
      ${googletest_SOURCE_DIR}/googletest/include
      ${googletest_SOURCE_DIR}/googletest/src
      ${googletest_SOURCE_DIR}/googletest
      )
  endif()
endif()
