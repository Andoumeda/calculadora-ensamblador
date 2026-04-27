.model small
.stack 100h

.data
    msjNum db 13, 10, "Ingrese un numero de 2 digitos: $"
    msjOpe db 13, 10, "Ingrese operacion: $"
    msjResult db 13, 10, "Resultado: $"

.code
start:
    mov ax, @data
    mov ds, ax
    
    mov dx, offset msjNum
    call puts
    call leerNum2Digitos
    mov bl, al
    
    mov dx, offset msjOpe
    call puts
    call getc
    mov bh, al
    
    mov dx, offset msjNum
    call puts
    call leerNum2Digitos
    
    mov dx, offset msjResult
    call puts
    call calcular
    call imprimirNum2Digitos
    
    call finish
    
calcular:
    cmp bh, '+'
    je sumar
    
    cmp bh, '-'
    je restar
    
    cmp bh, '*'
    je multiplicar
    
    ret

sumar:
    add al, bl
    ret

restar:
    sub bl, al
    mov al, bl
    ret

multiplicar:
    mov ch, 0
    mov cl, al
    mov al, bl
    
    cmp cl, 0
    je resultadoCero
    
    dec cl
    cmp cl, 0
    je retornar

multiplicarLoop:
    call sumar
    loop multiplicarLoop
    ret

retornar:
    ret

resultadoCero:
    mov al, 0
    ret

leerNum2Digitos:
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
    
imprimirNum2Digitos:
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
