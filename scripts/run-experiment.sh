#!/bin/sh



SIM="$1"

for filename in tests/*.riscv; do 
    echo $SIM $filename > $filname.out 
done 
