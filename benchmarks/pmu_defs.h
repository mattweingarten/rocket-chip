#ifndef PMU_DEFS_H_
#define PMU_DEFS_H_

#include <riscv-pk/encoding.h>
#include <stdint.h>
#include <stdio.h>

#define MAX_PMU_COUNT 31

#ifndef PMU_COUNT
#define PMU_COUNT MAX_PMU_COUNT
#endif



#define read_csr_safe(reg) ({ register long __tmp asm("a0"); \
        asm volatile ("csrr %0, " #reg : "=r"(__tmp)); \
        __tmp; })


#define EN_MASK 0xFFFFFFFF

// Existing Event Sets
#define INS_EVT  0x1UL
#define UOP_EVT  0x2UL
#define MEM_EVT  0x3UL

// Additional Event Sets
#define CUS_EVT  0x4Ul


#define EVT(n)   1UL<<(n + 8)


// Events for Event set INS_EVT
#define EXC_TAK EVT(0)
#define INT_LOAD_RET EVT(1)
#define INT_STORE_RET EVT(2)
#define ATOM_MEM_RET EVT(3)
#define SYST_INS_RET EVT(4)
#define INT_ARITH_RET EVT(5)
#define COND_BR_RET EVT(6)
#define JAL_RET EVT(7)
#define JALR_RET EVT(8)
#define INT_MULT_RET EVT(9)
#define INT_DIV_RET EVT(10)
#define FP_LOAD_RET EVT(11)
#define FP_STORE_RET EVT(12)
#define FP_ADD_RET EVT(13)
#define FP_MULT_RET EVT(14)
#define FP_FMA_RET EVT(15)
#define FP_DIV_SQRT_RET EVT(16)
#define FP_OTHER_RET EVT(17)

// Events for Event set UOP_EVT
#define LOAD_INTER EVT(0)
#define LONG_LAT_INTER EVT(1)
#define CSR_INTER EVT(2)
#define ICACHE_BUSY EVT(3)
#define DCACHE_BUSY EVT(4)
#define BR_DIR_MISPR EVT(5)
#define BR_TRG_MISPR EVT(6)
#define PIP_FLSH_CSR EVT(7)
#define PIP_FLSH_OTHER EVT(8)
#define INT_MULT_INTER EVT(9)
#define FP_INTER EVT(10)


// Events for Event set MEM_EVT
#define ICACHE_MISS EVT(0)
#define DCACHE_MISS EVT(1)
#define DCACHE_WB EVT(2)
#define ITLB_MISS EVT(3)
#define DTLB_MISS EVT(4)

uint64_t start[MAX_PMU_COUNT]; 
uint64_t end[MAX_PMU_COUNT]; 
char* name[MAX_PMU_COUNT]; 




void enable_csr(){
    write_csr(mcounteren, EN_MASK);
    write_csr(scounteren, EN_MASK); 
}

void set_counters_config_1(){
    name[0] = "Cycle";
    name[1] = "Int Ret";
    write_csr(mhpmevent3, INS_EVT | INT_STORE_RET | INT_LOAD_RET);
    name[2] = "Store/Load Ret";

    write_csr(mhpmevent4, INS_EVT | ATOM_MEM_RET | SYST_INS_RET);
    name[3] = "Atom/Sys Ret";
    write_csr(mhpmevent5, INS_EVT | COND_BR_RET | JAL_RET | JALR_RET);
    name[4] = "Branch Ret";
    write_csr(mhpmevent6, INS_EVT | INT_ARITH_RET | INT_DIV_RET | INT_MULT_RET);
    name[5] = "Int Ret";
    write_csr(mhpmevent7, INS_EVT | FP_ADD_RET | FP_DIV_SQRT_RET | FP_FMA_RET | FP_OTHER_RET);
    name[6] = "FP Ret";
    write_csr(mhpmevent8, UOP_EVT | INT_MULT_INTER | FP_INTER | LOAD_INTER | CSR_INTER );
    name[7] = "Inter";
    write_csr(mhpmevent9, UOP_EVT | ICACHE_BUSY);
    name[8] = "ICache Busy";
    write_csr(mhpmevent10, UOP_EVT | DCACHE_BUSY);
    name[9] = "DCache Busy";
    write_csr(mhpmevent11, UOP_EVT | BR_DIR_MISPR | BR_TRG_MISPR);
    name[10] = "Br miss";
    write_csr(mhpmevent12, UOP_EVT | PIP_FLSH_CSR | PIP_FLSH_OTHER);
    name[11] = "Pip flsh";
    write_csr(mhpmevent13, MEM_EVT | ICACHE_MISS);
    name[12] = "ICache miss";
    write_csr(mhpmevent14, MEM_EVT | ITLB_MISS);
    name[13] = "ITLB miss";
    write_csr(mhpmevent15, MEM_EVT | DCACHE_MISS);
    name[14] = "DCache miss";
    write_csr(mhpmevent16, MEM_EVT | DCACHE_WB);
    name[15] = "DCache WB";
    write_csr(mhpmevent17, MEM_EVT | DTLB_MISS);
    name[16] = "DTLB miss";
}

void read_start_counters(){
    start[0] = read_csr_safe(cycle);
    start[1] = read_csr_safe(instret);
    start[2] =  read_csr_safe(mhpmevent3);
    start[3] =  read_csr_safe(mhpmevent4);
    start[4] =  read_csr_safe(mhpmevent5);
    start[5] =  read_csr_safe(mhpmevent6);
    start[6] =  read_csr_safe(mhpmevent7);
    start[7] =  read_csr_safe(mhpmevent8);
    start[8] =  read_csr_safe(mhpmevent9);
    start[9] =  read_csr_safe(mhpmevent10);
    start[10] = read_csr_safe(mhpmevent11);
    start[11] = read_csr_safe(mhpmevent12);
    start[12] = read_csr_safe(mhpmevent13);
    start[13] = read_csr_safe(mhpmevent14);
    start[14] = read_csr_safe(mhpmevent15);
    start[15] = read_csr_safe(mhpmevent16);
    start[16] = read_csr_safe(mhpmevent17);
    start[17] = read_csr_safe(mhpmevent18);
    start[18] = read_csr_safe(mhpmevent19);
    start[19] = read_csr_safe(mhpmevent20);
    start[20] = read_csr_safe(mhpmevent21);
    start[21] = read_csr_safe(mhpmevent22);
    start[22] = read_csr_safe(mhpmevent23);
    start[23] = read_csr_safe(mhpmevent24);
    start[24] = read_csr_safe(mhpmevent25);
    start[25] = read_csr_safe(mhpmevent26);
    start[26] = read_csr_safe(mhpmevent27);
    start[27] = read_csr_safe(mhpmevent28);
    start[28] = read_csr_safe(mhpmevent29);
    start[29] = read_csr_safe(mhpmevent30);
    start[30] = read_csr_safe(mhpmevent31);
}



void start_counters(){
    enable_csr();
    set_counters_config_1();
    read_start_counters();
}


void end_counters(){
    end[0] = read_csr_safe(cycle);
    end[1] = read_csr_safe(instret);
    end[2] =  read_csr_safe(mhpmevent3);
    end[3] =  read_csr_safe(mhpmevent4);
    end[4] =  read_csr_safe(mhpmevent5);
    end[5] =  read_csr_safe(mhpmevent6);
    end[6] =  read_csr_safe(mhpmevent7);
    end[7] =  read_csr_safe(mhpmevent8);
    end[8] =  read_csr_safe(mhpmevent9);
    end[9] =  read_csr_safe(mhpmevent10);
    end[10] = read_csr_safe(mhpmevent11);
    end[11] = read_csr_safe(mhpmevent12);
    end[12] = read_csr_safe(mhpmevent13);
    end[13] = read_csr_safe(mhpmevent14);
    end[14] = read_csr_safe(mhpmevent15);
    end[15] = read_csr_safe(mhpmevent16);
    end[16] = read_csr_safe(mhpmevent17);
    end[17] = read_csr_safe(mhpmevent18);
    end[18] = read_csr_safe(mhpmevent19);
    end[19] = read_csr_safe(mhpmevent20);
    end[20] = read_csr_safe(mhpmevent21);
    end[21] = read_csr_safe(mhpmevent22);
    end[22] = read_csr_safe(mhpmevent23);
    end[23] = read_csr_safe(mhpmevent24);
    end[24] = read_csr_safe(mhpmevent25);
    end[25] = read_csr_safe(mhpmevent26);
    end[26] = read_csr_safe(mhpmevent27);
    end[27] = read_csr_safe(mhpmevent28);
    end[28] = read_csr_safe(mhpmevent29);
    end[29] = read_csr_safe(mhpmevent30);
    end[30] = read_csr_safe(mhpmevent31);

    for(unsigned int i = 0; i < MAX_PMU_COUNT; ++i){
        uint64_t diff = end[i] - start[i];
        printf("%s: 0x%llx\n",name[i], diff);
    }
}



#endif /*PMU_DEFS_H_*/