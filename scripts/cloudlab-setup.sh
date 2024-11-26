#!/bin/sh

OUT_DIR=/users/wmatt/

"cd $OUT_DIR"

mkdir lib/
"export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$OUT_DIR/lib"

mkdir tests/