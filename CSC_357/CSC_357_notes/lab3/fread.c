#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>


#define ARRAY_SIZE 1


int main() {
    FILE *f = fopen("//usr/lib/locale/locale-archive", "rb");

    char buffer[ARRAY_SIZE];


    size_t bytesRead;

    while ((bytesRead = fread(buffer, sizeof(char), sizeof(buffer), f)) > 0) {};
    
    fclose(f);
    return 0;}

// && counter <ARRAY_SIZE) {
//        int i;
        //printf("BytesRead: %d\n", bytesRead);
        //        for (i = 0; i < bytesRead; i++) {
        //                    // Process each byte individually
        //                                //printf("Byte: %c\n", buffer[i]);
        //                                        }
        //                                        //printf("Counter: %d\n", counter);
        //                                        //counter = counter + 1;                
        //                                                                           }
        //
        //                                                                               close(f);
        //
        //                                                                                   return 0;
        //                                                                                   }
        //
