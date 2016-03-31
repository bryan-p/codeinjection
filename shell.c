#include <unistd.h>

int main(int argc, char* argv[]) {
    char shell[] = "/bin/sh";

    execve(shell, NULL, NULL);

    return 0;
}
