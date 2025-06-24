section .data
    path DB "/home/uirian/Code/assembly-course/code/files/arquivo.txt", 0
    buffer DB "Write", 10, "to", 10, "file.", 0

    ; flags
    O_CREAT: DB 100o
    O_WRONLY: DB 1o
section .text

global main
main:
    mov eax, 5        ; open file/create
    mov ebx, path
    mov ecx, O_CREAT
    or ecx, O_WRONLY
    mov edx, 700o
    int 80h

    mov ebx, eax
    mov eax, 4
    mov ecx, buffer
    mov edx, 14
    int 80h

    mov eax, 1
    int 80h
