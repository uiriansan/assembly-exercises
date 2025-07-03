format binary
org 0x7c00

main:
    mov si, hello
    call print

    hlt
    jmp $

print_char:
    mov ah, 0x0e
    mov bh, 0
    int 10h
    jmp print

print:
    lodsb
    or al, al
    jnz print_char

    ret
    jmp $

hello: db "Hello, world!", 10, 0

times 510-($-$$) db 0
dw 0xaa55
