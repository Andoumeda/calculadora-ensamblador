.model small
.stack 100h

.data
    msgInput db 13, 10, "Ingrese un numero de 2 digitos: $"
    msgOpe db 13, 10, "Ingrese operacion: $"
    msgResult db 13, 10, "Resultado: $"

.code
start:
    mov ax, @data
    mov ds, ax
    
    mov dx, offset msgInput
    call puts
    call get2DigitNum
    mov bl, al
    
    mov dx, offset msgOpe
    call puts
    call getc
    mov bh, al
    
    mov dx, offset msgInput
    call puts
    call get2DigitNum
    
    mov dx, offset msgResult
    call puts
    call print2DigitNum
    
    mov dx, offset msgResult
    call puts
    mov al, bl
    call print2DigitNum
    
    call finish
    
get2DigitNum:
    push bx
    
    call getc
    mov bh, al
    sub bh, 30h
    
    call getc
    mov bl, al
    sub bl, 30h
    
    mov al, 10
    mul bh
    add al, bl
    
    pop bx
    ret
    
print2DigitNum:
    push ax
    push dx
    
    aam
    
    mov dl, ah
    add dl, 30h
    call putc
    
    mov dl, al
    add dl, 30h
    call putc
    
    pop dx
    pop ax
    ret

getc:
    mov ah, 1
    int 21h
    ret

putc:
    push ax
    
    mov ah, 2
    int 21h
    
    pop ax
    ret

puts:
    push ax
    
    mov ah, 9
    int 21h
    
    pop ax
    ret

finish:
    mov ah, 4ch
    int 21h

end start
