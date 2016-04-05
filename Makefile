CC=gcc
NASM=nasm
LD=ld
FLAGS = -ggdb -fno-stack-protector -z execstack
x86 = -m32

all: testsc testsc2 testsc3 vuln vuln32

testsc: testsc.c 
	$(CC) $(FLAGS) -o bin/testsc testsc.c

testsc2: testsc2.c 
	$(CC) $(FLAGS) -o bin/testsc2 testsc2.c

testsc3: testsc3.c 
	$(CC) $(FLAGS) -o bin/testsc3 testsc3.c

getenvaddr: getenvaddr.c 
	$(CC) $(FLAGS) -o bin/getenvaddr getenvaddr.c

getenvaddr32: getenvaddr.c 
	$(CC) $(FLAGS) $(x86) -o bin/getenvaddr32 getenvaddr.c

vuln: vulnerable.c 
	$(CC) $(FLAGS) -o bin/vuln vulnerable.c

vuln32: vulnerable.c 
	$(CC) $(FLAGS) $(x86) -o bin/vuln32 vulnerable.c
