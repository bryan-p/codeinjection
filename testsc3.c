/* 
 * testsh1.c
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define bufsz 100

const char msg[]="Usage: %s <shellcode file>\n";

char buffer[bufsz]; 

void usage(char *self) {
    printf(msg, self);
    exit(1);
}

/* 
 * return 
 * 0: buf[...] does NOT approximately match pattern[...]
 * 1: buf[...] approximately matches pattern[...]
*/
int approxPatternMatch(char *buf, char *pattern) {
    int i,j;

    for (i=j=0; buf[i] && pattern[j]; ) {
        if (buf[i] == pattern[j]) {
            i++; j++;
        }
        else 
            i++;
    }

    if (pattern[j] == 0) /* found an approximate match! */
        return 1;

    /* no match */
    return 0;
}

int main(int argc, char *argv[]) {
    FILE *fp;
    void (*funcptr)();

    if (argc != 2) usage(argv[0]);

    if ((fp=fopen(argv[1], "rb"))==NULL) {
        printf("fail to open file: %s\n", argv[1]);
        exit(1);
    }

    fgets(buffer, bufsz, fp);
    fclose(fp);

    if (approxPatternMatch(buffer, "/bin/sh") ||
            approxPatternMatch(buffer, "sh")) {
        printf("Malicious code detected! \n");
        return 1;
    }

    funcptr = (void *) buffer;
    (*funcptr)();  /* execute shell code */

  return 0 ;
}
