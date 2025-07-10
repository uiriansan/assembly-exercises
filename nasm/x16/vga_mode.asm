; https://en.wikipedia.org/wiki/INT_10H
bits 16
org 0x7c00

main:
    mov ah, 00h
    mov al, 13h
    int 10h

    push 0xa000
    pop es

    mov al, 0x1         ; blue
    mov cx, 320*200     ; VGA mode 13 is a linear frame buffer
    xor di, di
    rep stosb           ; mov [es:di], 'al' and increment 'di' 'cx' number of times

    cli
    hlt
halt:
    jmp halt

times 510-($-$$) db 0
dw 0xaa55
