#!/bin/sh


CLOUDLAB="$1"
CHIPYARD="$2"
RTL_SIM="$3"


PWD="$(pwd)"

# OUT_DIR=/dev/shm
OUT_DIR=/users/"$4"

# scp $CHIPYARD/tests/*.riscv $CLOUDLAB:$OUT_DIR/tests/
# scp $CHIPYARD/sims/verilator/$RTL_SIM $CLOUDLAB:$OUT_DIR

# scp $CHIPYARD/.conda-env/riscv-tools/lib/*.so $CLOUDLAB:$OUT_DIR/lib

scp -r $CHIPYARD/.conda-env/lib/* $CLOUDLAB:$OUT_DIR/lib