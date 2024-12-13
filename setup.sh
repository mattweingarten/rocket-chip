#!/bin/sh

# checkout chipyard
git submodule set-url chipyard git@github.com:mattweingarten/chipyard.git
git submodule set-branch --branch rocket_chip_cpi chipyard
git submodule update --init chipyard
pushd chipyard/

# checkout rocket-chip
git submodule set-url generators/rocket-chip git@github.com:mattweingarten/rocket-chip.git
git submodule set-branch --branch rocket_chip generators/rocket-chip
git submodule update --init generators/rocket-chip

# checkout BOOM
git submodule set-url generators/boom git@github.com:mattweingarten/rocket-chip.git
git submodule set-branch --branch boom_chip generators/boom
git submodule update --init generators/boom

popd

./build-setup.sh riscv-tools  -s 4 -s 5 -s 6 -s 7 -s 8 -s 9
cd ../

cd riscv-test

git remote set-url origin git@github.com:mattweingarten/riscv-tests.git
cd .. /


# checkout Ibex
if [ -d ./ibex ]; then
  git submodule update --init ibex
  pushd ./ibex
  pip3 install -U -r python-requirements.txt
fi
