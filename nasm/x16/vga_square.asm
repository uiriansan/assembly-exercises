bits 16
org 0x7c00

R_WIDTH     equ 80
R_HEIGHT    equ 50
R_CENTER_X  equ (320 - R_WIDTH) / 2
R_CENTER_Y  equ (200 - R_HEIGHT) / 2

main:
    mov ah, 0x00
    mov al, 0x13
    int 10h                 ; VGA mode

    push 0xa000             ; VGA 13h frame buffer memory segment
    pop es                  ; set 'es' to video memory segment. We can't mov it directly

    mov al, 0x1             ; blue
    call paint_background

    mov bx, R_CENTER_X      ; x
    mov dx, R_CENTER_Y      ; y
    mov cx, R_WIDTH         ; width
    mov si, R_HEIGHT        ; height
    mov al, 0x4             ; color = red
    call draw_rect

    cli
    hlt

; Function to draw a filled rectangle
; Parameters:
;   - BX = x position
;   - DX = y position
;   - CX = width
;   - SI = height
;   - AL = color
draw_rect:
    push ax
    push si
    push cx
    push dx
    push bx

    ; Calculate starting position: y * 320 + x
    mov ax, dx          ; y position
    mov cx, 320
    mul cx              ; ax = y * 320
    add ax, bx          ; ax = y * 320 + x
    mov di, ax

    pop bx
    pop dx
    pop cx
    pop si
    pop ax

draw_row_loop:
    push di             ; save row start position
    push cx             ; save width

    rep stosb           ; draw the row

    pop cx              ; restore width
    pop di              ; restore row start position
    add di, 320         ; move to next row

    dec si
    jnz draw_row_loop

    ret

; Parameters:
;   AL: color
paint_background:
    mov cx, 320*200
    xor di, di
    rep stosb
    ret

times 510-($-$$) db 0
dw 0xaa55
