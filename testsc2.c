#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define bufsz 100

const char msg[]="Usage: %s <shellcode file>\n";

static char buffer1[bufsz];
static char buffer2[bufsz];

void usage(char *self) {
    printf(msg, self);
    exit(1);
}

int main(int argc, char *argv[]) {
    FILE *fp; 
    void (*funcptr)();
    if (argc != 2) usage(argv[0]);

    if ((fp=fopen(argv[1], "rb"))==NULL) {
        printf("fail to open file: %s\n", argv[1]);
        exit(1);
    }

    fgets(buffer1, bufsz, fp);
    fclose(fp);
    strcpy(buffer2, buffer1); 

    printf("shellcode is %d bytes\n", strlen(buffer2));

    if (strstr(buffer2, "/bin/sh"))
        printf("Malicious code detected!\n");

    funcptr = (void *) buffer2;
    (*funcptr)(); /* execute shell code */
    
    return 0 ;
}
