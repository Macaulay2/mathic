#include <mathic.h>
#include <memtailor.h>

#if defined(EXPECT_DEBUG) != defined(MATHIC_DEBUG)
#error Debug ABI must agree with the installed library
#endif
static_assert(__cplusplus >= 201703L, "C++17 must be inherited");

int main() {
  memt::Arena arena;
  void* p = arena.alloc(32);
  arena.freeTop(p);
  libmathicIsPresent();
}
