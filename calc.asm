.model small
.stack 100h

.data
    msgInput db "Ingrese un numero de 2 digitos: $"
    msgResult db 13, 10, "Resultado: $"

.code
start:
    mov ax, @data
    mov ds, ax
    
    mov dx, offset msgInput
    call puts
    call get2DigitNum
    
    mov dx, offset msgResult
    call puts
    call print2DigitNum
    
    call finish
    
get2DigitNum:
    call getc
    mov bh, al
    
    call getc
    mov bl, al
    
    ret
    
print2DigitNum:
    mov dl, bh
    call putc
    
    mov dl, bl
    call putc
    
    ret

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
