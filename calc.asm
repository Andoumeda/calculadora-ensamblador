.model small
.stack 100h

.data
    CR equ 13
    LF equ 10
    
    msjNum db CR, LF, "Ingrese un numero de 2 digitos: $"
    msjOpe db CR, LF, "Ingrese operacion: $"
    msjResult db CR, LF, "Resultado: $"
    msjBucle db CR, LF, "Desea continuar? Presione E para salir: $"

.code
start:
    mov ax, @data
    mov ds, ax
    
    call startLoop
    
    call finish
    
startLoop:
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
    
    mov dx, offset msjBucle
    call puts
    call getc
    
    cmp al, 'E'
    jne startLoop
    
    ret

calcular:
    cmp bh, '+'
    je sumar
    
    cmp bh, '-'
    je restar
    
    cmp bh, '*'
    je multiplicar
    
    cmp bh, '/'
    je dividir
    
    cmp bh, 'p'
    je potencia
    
    cmp bh, 'P'
    je potencia
    
    cmp bh, 's'
    je sumatoria
    
    cmp bh, 'S'
    je sumatoria
    
    cmp bh, 'f'
    je factorial
    
    cmp bh, 'F'
    je factorial
    
    ret

sumar:
    add al, bl
    ret

restar:
    sub bl, al
    mov al, bl
    ret

multiplicar:
    push cx
    
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
    
    pop cx
    ret

dividir:
    push cx
    
    mov cl, 0
    
    cmp bl, 0
    je resultadoCero

dividirLoop:
    sub bl, al
    inc cl
    
    cmp bl, 0
    jg dividirLoop
    
    mov al, cl
    pop cx
    ret

potencia:
    push cx
    
    mov ch, 0
    mov cl, al
    mov al, bl
    
    cmp cl, 0
    je resultadoUno
    
    dec cl
    cmp cl, 0
    je retornar

potenciaLoop:
    call multiplicar
    loop potenciaLoop
    
    pop cx
    ret

sumatoria:
    push cx
    
    mov al, bl
    cmp bl, 0
    je resultadoCero
    
    dec bl
    cmp bl, 0
    je resultadoUno
    
    mov ch, 0
    mov cl, bl

sumatoriaLoop:
    call sumar
    dec bl
    loop sumatoriaLoop
    
    pop cx
    ret

factorial:
    push cx
    
    mov al, bl
    cmp bl, 0
    je resultadoUno
    
    dec bl
    cmp bl, 0
    je resultadoUno
    
    mov ch, 0
    mov cl, bl
    dec cl

factorialLoop:
    call multiplicar
    dec bl
    loop factorialLoop
    
    pop cx
    ret

retornar:
    pop cx
    ret

resultadoCero:
    mov al, 0
    pop cx
    ret

resultadoUno:
    mov al, 1
    pop cx
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
