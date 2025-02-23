/*
This program will take two command-line arguments. 
The first is the name of another program and the 
second is the name of a file (which need not yet exist).

Your program is going to use "exec" to run the specified 
program. Before doing so, however, your program will need 
to open the specified file and take the appropriate steps 
to redirect standard output to the specified file. This 
setup is done so that the exec’d program will write its 
output to the file.

Recall discussions of file descriptions (including 
standard uses), open, and dup.
*/
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    // Check for valid input
    if (argc != 3) {
        perror("Incorrect number of arguments provided. Exiting program.");
        return 1;
    }

    // Save input in variables
    char *programToRun = argv[1];
    char *outputFile = argv[2];

    // Open output file
    //fopen --> FILE *name
    FILE *outputDescrip = fopen(outputFile, "a");
    //int outputFileDescriptor = open(outputFile, "a"); // Adds to end of file if it exists, creates file if it doesn't.
    if (outputDescrip == NULL) { //N-1
       perror("Error opening file");
       return 1;
    }

    // Convert file pointer to descriptor
    int output = fileno(outputDescrip);

    // dup2 to redirect
    if (dup2(output, 1) == -1) { // STDOUT_FILENO == 1
        perror("Redirection failed. Exiting program.");
        fclose(outputDescrip);
        return 1;
    }

    fclose(outputDescrip); // Close file // DOES THIS NEED TO BE AFTER EXECUTION?

    if (execlp(programToRun, programToRun, NULL) == -1) {
        perror("Execution failed. Exiting program.");
        return 1;
    }

    return 0;
}