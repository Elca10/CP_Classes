#define _GNU_SOURCE
#include "net.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

#define PORT 65432 // 2828 --> any num between 1024 and 65535



void handle_request(int nfd)
{
   FILE *network = fdopen(nfd, "r+"); // r --> r+ so that it can read + write
   char *line = NULL;
   size_t size;
   ssize_t num;

   if (network == NULL)
   {
      perror("fdopen");
      close(nfd);
      return;
   }

   while ((num = getline(&line, &size, network)) >= 0)
   {
      // Write to client
      write(nfd, line, num);
   }

   free(line);
   fclose(network);
}

void run_service(int fd)
{
   while (1)
   {
      int nfd = accept_connection(fd);
      if (nfd != -1)
      {
         pid_t pid = fork();
         if (pid == 0) {
            // Child process 
            close(fd);
            printf("Connection established\n");
            handle_request(nfd);
            printf("Connection closed\n");
            close(nfd); // Done with this socket
            exit(0); // Exit child process - success
         } else if (pid > 0) {
            // Parent process
            close(nfd); // Don't need this socket for parent
         } else {
            perror("Fork failed.");
            continue; // Not exit because it can accept new connections
         }
         
      }
   }
}


void sigHandler(int sig) {
    int status;
    pid_t pid;

    // Wait for child processes to terminate
    while ((pid = waitpid(-1, &status, WNOHANG)) > 0) {
      printf("Child terminated - another client request finished.");
    }
}

int main(void)
{
   int fd = create_service(PORT);

   if (fd == -1)
   {
      perror(0);
      exit(1);
   }

// Make a SIGCHLD handler
   struct sigaction sa;
   sa.sa_handler = sigHandler;
   sa.sa_flags = 0;
   sigemptyset(&sa.sa_mask);

   if (sigaction(SIGCHLD, &sa, NULL) == -1) {
      perror("sigaction");
      close(fd);
      exit(1);
   }

   printf("listening on port: %d\n", PORT);
   run_service(fd);
   close(fd);

   return 0;
}
