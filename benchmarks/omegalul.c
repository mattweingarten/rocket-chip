// a very short test lol
#include "pmu_defs.h"
extern void crt;

// __attribute__((always_inline)) long haha(long a) {
//     return ~a;
// }

int main() {
    #ifdef PMU
        start_counters(); 
    #endif
    int a = 29038;
    int b = a + 12;
    int* c;
    *c = b;
    // a = haha(a);
    a = ~a;

    #ifdef PMU
        end_counters(); 
    #endif
    
    return 0;
}
