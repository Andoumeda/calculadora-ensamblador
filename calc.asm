.model small
.stack 100h

.data
    msgInput db "Ingrese un numero: $"
    msgResult db 13, 10, "Resultado: $"

.code
start:
    mov ax, @data
    mov ds, ax
    
    mov dx, offset msgInput
    call puts
    call getc
    mov bl, al
    
    mov dx, offset msgResult
    call puts
    
    mov dl, bl
    call putc
    
    call finish
    
getc:
    mov ah, 1
    int 21h
    ret

putc:
    mov ah, 2
    int 21h
    ret

puts:
    mov ah, 9
    int 21h
    ret

finish:
    mov ah, 4ch
    int 21h

end start
