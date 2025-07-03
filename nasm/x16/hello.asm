bits 16
org 0x7c00

main:
    mov si, hello
    call print

    hlt
halt:
    jmp halt

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
    jmp halt

hello: db "Hello, world!", 0x0d, 0x0a, 0

times 510-($-$$) db 0
dw 0xaa55
