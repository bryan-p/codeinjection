#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void usage(const char *self) {
    printf("Usage: %s <buffer overflow string>\n", self);
    exit(1);
}

void vuln(char *arg) {
  char vulbuff[64];

  strcpy(vulbuff, arg);  /* potential buffer overflow spot */
  printf("vulbuff: %p\n", &vulbuff);
}
int main(int argc, char *argv[]) {
  //char vulbuff[33];

  if (argc!=2) usage(argv[0]);
  
  printf("the length of input string is %d chars, press any key to continue ...\n", strlen(argv[1]));
  vuln(argv[1]);

  //strcpy(vulbuff, argv[1]);  /* potential buffer overflow spot */
  //getchar();                 /* for your debugging :) */

  return 0 ;
}

