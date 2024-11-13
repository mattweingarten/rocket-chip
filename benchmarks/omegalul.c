// a very short test lol

extern void crt;

// __attribute__((always_inline)) long haha(long a) {
//     return ~a;
// }

int main() {
    int a = 29038;
    int b = a + 12;
    int* c;
    *c = b;
    // a = haha(a);
    a = ~a;
    
    return 0;
}
