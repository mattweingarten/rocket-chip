# RISC-V PMU project

## Collaborators

Micheal (mag2346)
Prathmesh (pp2870)
Matt (mew2260)


# General Setup

DO NOT use git submodule recurse. Follow steps here.



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






















