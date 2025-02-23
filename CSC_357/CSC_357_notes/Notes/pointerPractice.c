#include <stdio.h>

int main() {
    int x = 10;
    printf("x: %d, size of x:%lu\n", x, sizeof(x));

    int *p = &x;
    //printf("p: %d, size of p:%lu\n", p, sizeof(p));
    //printf("p: %d, size of p:%lu\n", &p, sizeof(p));
    printf("p value: %d, size of p:%lu\n", *p, sizeof(p));
    printf("p: %p, size of p:%lu\n", p, sizeof(p));

    int *p2 = x;
    printf("p2: %d, size of p2:%lu\n", p2, sizeof(p2));


    int a[] = {1,2,3};



    return 1;
}

