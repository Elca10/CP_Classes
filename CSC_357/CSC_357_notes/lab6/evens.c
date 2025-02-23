/*
must take a single integer, N, as a command-line argument.
evens prints the even numbers from 1 to N (inclusive); 
formatting for evens and odds should be as in task 1.
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    int N = atoi(argv[1]);
    int n = 1;
    for (n; n <= N; n++) {
        // if even (evenly divisible by 2)
        if (n % 2 == 0) {
            printf("\t%d\n", n);
        }
    }

    return 0;
}