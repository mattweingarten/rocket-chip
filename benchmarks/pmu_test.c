#include <stdio.h>


#define read_csr_safe(reg) ({ register long __tmp asm("a0"); \
        asm volatile ("csrr %0, " #reg : "=r"(__tmp)); \
        __tmp; })

int main(void) {


write_csr(mcounteren, -1); // Enable supervisor use of all perf counters
write_csr(scounteren, -1); // Enable user use of all perf counters



// read cycle and instruction counts in user mode
uint64_t csr_cycle  = read_csr_safe(cycle);
uint64_t csr_instr  = read_csr_safe(instret);

int a = 0;

for(int i = 0; i < 100; ++i){
    a += i;
}

printf("%d\n", a);

printf("Value of cycle (zero'd): %ld\n", read_csr_safe(cycle) - csr_cycle);

printf("Value of instr (zero'd): %ld\n", read_csr_safe(instret) - csr_instr);
}