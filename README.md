mathic
======

Mathic is a C++ library of fast data structures designed for use in
Groebner basis computation. This includes data structures for ordering
S-pairs, performing divisor queries and ordering polynomial terms
during polynomial reduction.

With Mathic you get to use highly optimized code with little effort so
that you can focus more of your time on whatever part of your Groebner
basis implementation that you are interested in. The data structures
use templates to allow you to use them with whatever representation of
monomials/terms and coefficients that your code uses. In fact the only
places where Mathic defines its own monomials/terms is in the test
code and example code. Currently only dense representations of
terms/monomials are suitable since Mathic will frequently ask "what is
the exponent of variable number x in this term/monomial?".

The paper "Practical Grobner Basis Computation" describes the data
structures from a high level. It was presented at ISSAC 2012 and is
available at http://arxiv.org/abs/1206.6940

The following copyright and license notice applies to all of the files in
mathic.

Copyright 2012 2013 Bjarke Hammersholt Roune (http://www.broune.com) and Michael Stillman

Mathic is licensed for use under the terms of GNU Lesser General Public License
version 2.0, and under any later version; the option is yours.  See the files
lgpl-*.txt in this directory.

## Building with CMake

This build requires CMake 3.18 or newer and a C++17 compiler.

```sh
cmake -S . -B build-dir -GNinja -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/your/install/prefix
cmake --build build-dir
ctest --test-dir build-dir --output-on-failure
cmake --install build-dir
```

Mathic needs [memtailor](https://github.com/Macaulay2/memtailor). CMake looks
for it in this order: memtailor's CMake package (installed by memtailor 1.5 or
later when built with CMake), its pkg-config file, and finally its header and
library directly. Prefer the first two: only they tell Mathic whether memtailor
was built with `MEMT_DEBUG`, which changes memtailor's data layout, so Mathic
must be compiled to match. If memtailor is in a nonstandard location, pass
`-DCMAKE_PREFIX_PATH=/its/prefix` (separate several prefixes with semicolons,
quoted; the environment variable uses colons).

`-DBUILD_TESTING=OFF` skips the unit tests and the GoogleTest dependency.

## Using an installed Mathic

A CMake installation, shared or static, provides headers, pkg-config metadata,
and a relocatable CMake package under the platform's library directory. An
Autotools installation provides headers and pkg-config metadata only, without
the Debug flag described below. In a CMake project:

```cmake
find_package(mathic 1.6 CONFIG REQUIRED)
target_link_libraries(my_program PRIVATE mathic::mathic)
```

Linking to `mathic::mathic` sets up everything needed to build against Mathic:
it adds Mathic's include directory, links memtailor, and compiles your program
as C++17 or later, which Mathic's headers require.

`find_package(mathic)` in turn looks for memtailor's CMake package, which
memtailor installs only from version 1.5 on, and only when memtailor itself
was built with CMake.

A Debug build of Mathic defines `MATHIC_DEBUG`, which changes its data layout.
In a CMake installation, both the CMake package and `pkg-config --cflags mathic`
pass that flag on, so programs using Mathic match it even when they're built in
Release mode. With pkg-config you also need to request C++17 or later yourself.
