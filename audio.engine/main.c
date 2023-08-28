
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <string.h>




void *
clientThread(void *arg)
{
    // Create a socket
    int clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    if (clientSocket == -1) {
        perror("socket");
        return NULL;
    }

    // Set up the server address
    struct sockaddr_in serverAddress;
    serverAddress.sin_family = AF_INET;
    serverAddress.sin_port = htons(12345);  // Port of the server
    serverAddress.sin_addr.s_addr = inet_addr("127.0.0.1");  // IP address of the server

    // Connect to the server
    if (connect(clientSocket, (struct sockaddr *)&serverAddress, sizeof(serverAddress)) == -1) {
        perror("connect");
        close(clientSocket);
        return NULL;
    }

    printf("Connected to the server\n");

    // Send data to the server
    const char *message = "Hello";
    if (send(clientSocket, message, strlen(message), 0) == -1) {
        perror("send");
    }

    // Close the socket
    close(clientSocket);

    return NULL;
}

int
main()
{
    pthread_t thread;

    // Create a new thread for the client
    if (pthread_create(&thread, NULL, clientThread, NULL) != 0) {
        perror("pthread_create");
        return 1;
    }

    // Wait for the client thread to finish
    if (pthread_join(thread, NULL) != 0) {
        perror("pthread_join");
        return 1;
    }

    return 0;
}
