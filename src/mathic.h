// Include this file to pull in all external Mathic files

// utilities
#include "mathic/Timer.h"
#include "mathic/ColumnPrinter.h"
#include "mathic/error.h"

// other data structures
#include "mathic/BitTriangle.h"
#include "mathic/HashTable.h"

// divisor query data structures
#include "mathic/DivList.h"
#include "mathic/KDTree.h"

// priority queue data structures
#include "mathic/TourTree.h"
#include "mathic/StlSet.h"
#include "mathic/Heap.h"
#include "mathic/Geobucket.h"
#include "mathic/PairQueue.h"

// CLI package
#include "mathic/Action.h"
#include "mathic/BoolParameter.h"
#include "mathic/CliParameter.h"
#include "mathic/CliParser.h"
#include "mathic/HelpAction.h"
#include "mathic/IntegerParameter.h"
#include "mathic/StringParameter.h"
#include "mathic/display.h"

extern "C" {
  // Put a C function in the library so that it can be detected by the autoconf
  // macro AC_CHECK_LIB. That macro can only check for libraries that contain
  // at least one C function.
  void libmathicIsPresent(void); // This function does nothing.
  extern char MATHIC_VERSION_STRING[];
}
