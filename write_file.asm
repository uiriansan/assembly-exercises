section .data
    path DB "/home/uirian/Code/assembly-exercises/test.txt", 0
    buffer DB "Write", 10, "to", 10, "file.", 0

    ; flags
    O_CREAT: DB 100o ; Create file if it doesn't exist
    O_WRONLY: DB 1o  ; Write only
section .text

global main
main:
    mov eax, 5        	; open file/create
    mov ebx, path
    mov ecx, O_CREAT
    or ecx, O_WRONLY
    mov edx, 700o
    int 80h

    mov ebx, eax
    mov eax, 4			; write buffer to file
    mov ecx, buffer
    mov edx, 14
    int 80h

    mov eax, 1
	mov ebx, 0
    int 80h
