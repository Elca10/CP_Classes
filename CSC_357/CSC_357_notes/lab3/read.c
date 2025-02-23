#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>


#define ARRAY_SIZE 8192


int main() {
    int f = open("//usr/lib/locale/locale-archive", O_RDONLY);
    
    char buffer[ARRAY_SIZE];

    
    ssize_t bytesRead;

    while ((bytesRead = read(f, buffer, sizeof(buffer))) > 0) {// && counter <ARRAY_SIZE) {
	int i;
	//printf("BytesRead: %d\n", bytesRead);
        for (i = 0; i < bytesRead; i++) {
            // Process each byte individually
            //printf("Byte: %c\n", buffer[i]);
        }
//printf("Counter: %d\n", counter);
//counter = counter + 1;                
                                   }

    close(f);
    
    return 0;
}

