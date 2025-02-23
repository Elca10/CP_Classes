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
This program will behave similarly to the program from the first part, 
but will use one of the "exec" system calls to execute the programs 
written in the Task 2. The parent should fork two child processes. 
One child process will "exec" the odds program. The other will "exec" 
the evens program. The parent process should properly wait for both 
child processes to terminate but allow them to execute concurrently 
(i.e., wait after both children have been created).
*/

int main(int argc, char* argv[]) {
    rlim_t max_processes = 300;
    limit_fork(max_processes);

    int N = atoi(argv[1]); // argv[0] is file

    // fork for odds
    pid_t pid_odds = fork();

    // if failed, error
    if (pid_odds < 0) {
        perror("Error occurred with oddsfork. Exiting.");
        return 1;
    // if child (pid = 0) - for odds
    } else if (pid_odds == 0) {
        // print odd nums from 1 to N
        if (execlp("./odds", "odds", argv[1], NULL) == -1) {
            perror("Execlp failed");
            return 1;
        }
        // exit
        exit(0); // zero for success (see documentation)
    }

    // fork for evens
    pid_t pid_evens = fork();
    
    // if failed, error
    if (pid_evens < 0) {
        perror("Error occurred with evens fork. Exiting.");
        return 1;
    // if child (pid = 0) - for evens
    } else if (pid_evens == 0) {
        // print even nums from 1 to N
        //TODO: call evens.c
        if (execlp("./evens", "evens", argv[1], NULL) == -1) {
            perror("Execlp failed");
            return 1;
        }
    }

    // if (pid_odds > 0 && pid_evens > 0) {
    //     // wait for children to finish?
    // }
    // In parent process, wait for both
    int statusOdds, statusEvens;
    waitpid(pid_odds, &statusOdds, 0);
    waitpid(pid_evens, &statusEvens, 0);


    return 0;
}