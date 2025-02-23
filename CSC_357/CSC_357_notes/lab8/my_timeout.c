#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>


// Global var for childPid because timerHandler can't take in other arguments
pid_t childPid = -1; 


static void timerHandler(int signum)
{
    if (childPid > 0) {
        printf("Killing child...\n");
        kill(childPid, SIGKILL);  // Kill the child process
    }
}



int main(int argc, char* argv[]) {
    if (argc < 3) {
        perror("Not enough arguments provided. Exiting program.");
        return 1;
    }

    int timeout = atoi(argv[1]);
    if (timeout <= 0) {
        perror("Invalid timeout number. Must be positive integer.");
        return 1;
    }
    
    // Set up the timer
    // Source: https://pubs.opengroup.org/onlinepubs/007904875/functions/sigaction.html
    // Set up the SIGALRM handler
    struct sigaction sa;
    sa.sa_handler = timerHandler;
    sa.sa_flags = 0;
    sigemptyset(&sa.sa_mask);

    if (sigaction(SIGALRM, &sa, NULL) == -1) {
        perror("Sigaction error. Could not set up timer. Exiting program.");
        return 1;
    }

    // Fork a child process for executing command
    childPid = fork();

    if (childPid == 0) {
        // Child process
        execvp(argv[2], &argv[2]);
        // Reaching here means execution failed
        perror("Could not execute command. Exiting program."); 
        exit(1);
    } else if (childPid > 0) {
        // Parent process
        alarm(timeout);

        // Wait for the child process
        int status;
        waitpid(childPid, &status, 0);
        
        // Stop alarm if child finishes in time
        alarm(0);

        // Exit with the child's exit status if it terminated normally
        if (WIFEXITED(status)) {
            return WEXITSTATUS(status);
        }

        // Else (if it was killed or something else went wrong), exit with a non-zero status
        return 1;

    } else {
        perror("Fork error. Exiting program.");
        return 1;
    }
}


/*
Write a program, named my_timeout, that can be used to limit the duration of another program. 
my_timeout takes, as command-line arguments, an integer number of seconds and another command 
(optionally with arguments of its own). The my_timeout program must spawn a child process to 
execute the argument command (with its command-line arguments) and set an alarm that will be 
triggered after the specified number of seconds (use sigaction). If the child process has not 
terminated by the time that the alarm has triggered, then it should be killed (and the exit 
status of my_timeout should be non-zero). If the child process terminates, then the exit 
status of my_timeout should be that of the child process.
*/