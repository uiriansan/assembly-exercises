extern printf

section .data
    hello db "Hello, world!", 0
    fmt db "%s", 10, 0
section .text

global main
main:
    push hello
    push fmt
    call printf

    mov eax, 1
    mov ebx, 0
    int 80h
