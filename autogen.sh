#!/bin/sh
srcdir=$(dirname $0)
test -z "$srcdir" && srcdir=.

autoreconf --verbose --install --force $srcdir
