format elf

extrn printf
public main

section '.text' executable
main:
    push hello
    push fmt
    call printf

    mov eax, 1
    mov ebx, 0
    int 80h

section '.data' writeable
    hello db "Hello, world!", 0
    fmt db "%s", 10, 0
