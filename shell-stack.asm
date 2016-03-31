BITS 32

global _start

section .text
_start:

execve:
    ; int execve(const char *filename, char *const argv [], char *const envp[])
    ;                     ebx                 ecx                edx

    xor eax, eax
    push eax          ; null terminate following string on stack

    ; push ////bin/bash str on stack
    push 0x68732f2f   ; //sh
    push 0x2f6e6962   ; bin/
    push 0x2f2f2f2f   ; ////

    mov ebx, esp      ; point ebx to beginning of string just pushed

    push eax          ; null terminate following 
    mov edx, esp      ; edx points to null on stack 

    push ebx          ; push address os /bin/sh on stack
    mov ecx, esp      ; point ecx to that address

    mov al, 11        ; Syscall #11
    int 0x80          ; Do it.
