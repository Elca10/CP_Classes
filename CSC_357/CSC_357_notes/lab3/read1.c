#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>

#define BYTES 64
int main() {
    int fd;
    char buffer[BYTES];
    ssize_t bytes_read;

    // Open the file for reading
    fd = open("/usr/lib/locale/locale-archive", O_RDONLY); 
    if (fd == -1) {
	printf("Error opening file");}
    // Read BYTES bytes from the file
     bytes_read = read(fd, buffer, BYTES); 
 
    if (bytes_read == -1) {
   	 perror("read");
    	 return 1;                                    
    }
   
    buffer[bytes_read] = '\0';
    printf("Read %zd bytes: %s\n", bytes_read, buffer);
    close(fd);
    return 0;
}
   




          // Null-terminate the buffer to print as a string
    //                                             buffer[bytes_read] = '\0';
    //
    //                                                 printf("Read %zd bytes: %s\n", bytes_read, buffer);
    //
    //                                                     close(fd);
    //                                                         return 0;
    //                                                         }
