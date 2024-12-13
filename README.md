# RISC-V PMU project

## Collaborators

Michael (mag2346)
Prathmesh (pp2870)
Matt (mew2260)


# General Setup

DO NOT use git submodule recurse. Follow steps here.

## RocketChip setup

### Step 1 -- Install Conda

```
wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
```

Install Conda to default location
```
bash Miniforge3-$(uname)-$(uname -m).sh
```

Setup conda executable
```
mv /home/$USER/miniforge3/bin/_conda  mv /home/$USER/miniforge3/bin/conda
```

```
export PATH=$PATH:/home/$USER/miniforge3/bin/
```

Install conda packages

```
conda install -n base conda-libmamba-solver
conda config --set solver libmamba

conda config --add channels ucb-bar
conda config --set channel_priority strict
conda install firtool
```

Start the virtual environment (you may need to run `conda init` first then restart your bash session)

```
conda activate base
```


Make sure we have all dependencies.
Setup script should take care of everything: 

```
bash setup.sh
```

From now on always set env before running any command:
```
source chipyard/env.sh
```

### Step 2: Build Verilator simulator for cores

As a starting point we will run traditional RTL simulation. In future, when performance becomes an issue, we can consider using hardware accelerated simulation with FireSim instead.


```
cd sims/verilator
```

We can build a Simulator for a specific Core, for now we have test only `[RocketConfig, SmallBoomConfig, IbexConfig]`

```
make CONFIG=<config>
```

This should produce a harness binary, depending on the config used. Example for SmallBoomConfig

```
simulator-chipyard.harness-RocketConfig
```

The harness can be executed with a `*.riscv` binary and simulate the execution. To make sure everything is setup properly, run a hello world test. Note that this does not work for simulating Ibex core.


First, we need to build the test. cd into `<path-to-riscv-pmu-core>/chipyard/tests`

Run `make` (in correct conda env).

This should build all benchmarks, including `hello.riscv`

Now from top-level directory, we can run


```
./chipyard/sims/verilator/simulator-chipyard.harness-RocketConfig ./chipyard/tests/hello.riscv
```

This may take a few mins, but the output should be: 

```
[UART] UART0 is here (stdin/stdout).
Hello world from core 0, a rocket


```


### Step 3: Running dhrystone micro-benchmark 

Dhrystone is meant to test performance of processor for a small C benchmark. 


First cd into `<path-to-riscv-pmu-core>/riscv-tests/benchmarks`

Run `make` to build all benchmarks, producing `dhrystone.riscv`.

Next simulate `dhrystone.riscv` with same command as above: 



```
./chipyard/sims/verilator/simulator-chipyard.harness-RocketConfig ./riscv-tests/benchmarks/dhrystone.riscv
```


This should produce an output like this: 

```
[UART] UART0 is here (stdin/stdout).
Microseconds for one run through Dhrystone: 458
Dhrystones per Second:                      2182
mcycle = 229097
minstret = 187526
```

## Ibex setup

### Step 1: initialize and install requirements

#### Clone repository

```
cd <REPOSITORY_ROOT>
git submodule update --init ibex
cd ibex
git checkout master
```

#### Install Python packages

```
cd <REPOSITORY_ROOT>/ibex
pip3 install -U -r python-requirements.txt
```

#### Install Verilator

```
cd <INSTALL_DIRECTORY>

# clone repository
git clone https://github.com/verilator/verilator
cd verilator
git pull

# create configure script and run
autoconf
export VERILATOR_ROOT=`pwd`
./configure
export VERILATOR_AUTHOR_SITE=1
./configure --enable-longtests

# install
make -j `nproc`

# save paths to .bashrc file
echo "export VERILATOR_AUTHOR_SITE=1" >> ~/.bashrc
echo "export VERILATOR_ROOT=`pwd`" >> ~/.bashrc
echo "export PATH=\"`pwd`/bin:${PATH}`"" >> ~/.bashrc
```

#### Install RISC-V compiler

Please download a release of the lowrisc compiler from [GitHub](https://github.com/lowRISC/lowrisc-toolchains/releases).

Then, de-compress it and add the bin to your PATH variable (in your `~/.bashrc` file):

```

tar -xf  <location of your tar.gz> --strip-components=1 -C ~/.local

echo "export PATH="${PATH}:<location of the unzipped lowrisc-toolchain directory>/bin"

```

### Step 2: generate and compile RTL code

```
cd <REPOSITORY_ROOT>/ibex

# generate code
pushd topdown-monitor
make ibex
popd

# generate system with fusesoc
make build-simple-system
```

### Step 3: compile and run benchmark

```
cd <REPOSITORY_ROOT>/ibex

make run-simple-system
```

You should get the following output (your numbers may vary depending on the version:

```
Performance Counters
====================
Cycles:                      1804243
Instructions Retired:        574366
LSU Busy:                    156970
Fetch Wait:                  63709
Loads:                       69595
Stores:                      87375
Jumps:                       57541
Conditional Branches:        72499
Taken Conditional Branches:  47203
Compressed Instructions:     311410
Multiply Wait:               15600
Divide Wait:                 887112
Base Component:              575237
ICache Component:            63709
Branch Prediction Component: 0
Dcache Component:            0
Execution Component:         872070
Dependency Component:        293227
Frontend Cycles:             63709
Backend Cycles:              1.05968e+06
Frontend CPI:                0.1109
Backend CPI:                 1.8450
```
