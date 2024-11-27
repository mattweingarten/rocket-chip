\
#TODO allow for building 32 target


cd build/benchmarks/
rm *
cd ../../


cd benchmarks/
make clean
OPT=$1 PMU=1 make 
mv *.riscv ../build/benchmarks
cd ../

cd riscv-tests/benchmarks
make clean
OPT=$1 PMU=1 make
mv *.riscv ../../build/benchmarks