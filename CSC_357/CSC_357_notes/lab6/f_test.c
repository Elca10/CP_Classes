
#include <sys/resource.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// Given function to prevent over-forking
void limit_fork(rlim_t max_procs)
{
    struct rlimit rl;
    if (getrlimit(RLIMIT_NPROC, &rl))
    {
        perror("getrlimit");
        exit(-1);
    }
    rl.rlim_cur = max_procs;
    if (setrlimit(RLIMIT_NPROC, &rl))
    {
        perror("setrlimit");
        exit(-1);
    }
}

/*
This program must take a single integer, N, as a command-line argument. 
This program must fork a child process. 
The child must print the odd numbers from 1 to N (inclusive) and then exit(), 
while the parent prints the even numbers from 1 to N (inclusive). 
The parent process should properly wait for the child process to terminate.

For the odd numbers, use “%d\n” as the format string for printf. For the even numbers, use “\t%d\n” as the format string for printf.

Run the program with a large enough value for N to observe an interleaving in the output.
*/

int main(int argc, char* argv[]) {
    rlim_t max_processes = 300;
    limit_fork(max_processes);

    int N = atoi(argv[1]); // argv[0] is file

    // fork
    pid_t pid = fork();

    // if failed, error
    if (pid < 0) {
        perror("Error occurred with fork. Exiting.");
        return 1;
    // if child (pid = 0)
    } else if (pid == 0) {
        // print odd nums from 1 to N
        int n = 1;
        for (n; n <= N; n++) {
            // if odd (not evenly divisible by 2)
            if (n % 2 != 0) {
                printf("%d\n", n);
            }
        }
        // exit
        exit(0); // zero for success (see documentation)
    // else (parent)
    } else {
        // print even nums from 1 to N
        int n = 1;
        for (n; n <= N; n++) {
            // if even (evenly divisible by 2)
            if (n % 2 == 0) {
                printf("\t%d\n", n);
            }
        }
        // wait for child to terminate
        wait(NULL);
    }

    return 0;

}