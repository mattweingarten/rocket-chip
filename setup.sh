#!/bin/sh


git submodule update --init
cd chipyard/

git remote set-url origin git@github.com:mattweingarten/chipyard.git

git checkout rocket_chip_cpi

./build-setup.sh riscv-tools  -s 3 -s 4 -s 5 -s 6 -s 7 -s 8 -s 9


cd ../
