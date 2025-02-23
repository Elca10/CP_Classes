#include <stdio.h>
#include <string.h>

int main() {
    FILE *input = stdin;

    // Initialize vars for loop
    char *line = NULL;
    unsigned int len = 0;
    int read;
    char *prev_line = NULL;

    // Loop through each line in input
    while ((read = getline(&line, (size_t *)&len, input)) != -1) {
        // Split line into words
        // Get first one
        char* word = strtok(line, " \n"); // split full command at " " and "\n"
        while (word != NULL ) {
            printf( "\n%s", word);
            word = strtok(NULL, " \n");
        }
        printf("\n");
    }




    return 0;
}