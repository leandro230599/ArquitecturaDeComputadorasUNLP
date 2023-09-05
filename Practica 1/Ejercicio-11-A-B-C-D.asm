;  11) Subrutinas de cálculo

;  A)  Escriba la subrutina DIV que calcule el resultado de la división entre 2 números positivos. Dichos números deben
;      pasarse por valor desde el programa principal a la subrutina a través de la pila. El resultado debe devolverse también
;      a través de la pila por valor. 

org 1000h
dividiendo DB 10h
divisor DB 4h
resultado DB ?

org 3000h
DIV: mov bx, sp
     add bx, 4
     mov al, byte ptr[bx]
     add bx, 2
     mov ah, byte ptr[bx]
     mov cx, 0
     loop: cmp ah, 0
           jz fin
           js fin
           sub ah, al
           inc cl
           jmp loop
           fin: sub bx, 4
                mov [bx], cl
                ret
                     
org 2000h
mov bx, 0h ; Para que no tenga basura los BH
mov bl, dividiendo
push bx
mov bl, divisor
push bx
mov bl, resultado
push bx
call DIV
pop bx
mov resultado, bl

----------------------------------------------------------------------------------------------------------------------------------------

;  B)  Escriba la subrutina RESTO que calcule el resto de la división entre 2 números positivos. Dichos números deben
;      pasarse por valor desde el programa principal a la subrutina a través de registros. El resultado debe devolverse
;      también a través de un registro por referencia. 


 ORG 1000H
num1 DB 6H
num2 DB 4H
; subrutina resto
; Recibe dos números en los registros CH y CL
; Retorna el resto de la división entera (sin coma) de CH/CL
; Por ejemplo el resto de 6/4 es 2
 ORG 3000H
resto: MOV AL, 0 ; inicializo el resto en 0
 MOV DH, 0 ; inicializo el cociente de la división
 CMP CH, 0 ; CH tiene NUM2
 JZ FIN
 CMP CL, 0 ; CL tiene NUM1
 JZ FIN
DIV: SUB CL, CH
 JS RES ; si resultado negativo, voy a calcular el resto
 INC DH ; sumo al cociente
 JMP DIV
RES: ADD CL, CH ; sumo de vuelta CH para determinar el resto
 MOV AL, CL ; devuelvo el resto en AX
FIN: RET
ORG 2000H
MOV CL, num1
MOV CH, num2
CALL resto
HLT
END 
pop bx
pop bx
hlt
end

-------------------------------------------------------------------------------------------------------------------------------------------------

;  C)  Escribir un programa que calcule la suma de dos números de 32 bits almacenados en la memoria sin hacer llamados a
;      subrutinas, resolviendo el problema desde el programa principal. 

org 1000h
num1baja dw 5678h
num1alta dw 1234h
num2baja dw 5678h
num2alta dw 1234h
resbaja dw ?
resalta dw ?

org 2000h
mov ax, num1alta
mov bx, num1baja
mov cx, num2alta
mov dx, num2baja
add bx, dx
adc ax, cx
mov resbaja, bx
mov resalta, ax
hlt
end

-------------------------------------------------------------------------------------------------------------------------------------------------------

;  D)  Escribir un programa que calcule la suma de dos números de 32 bits almacenados en la memoria llamando a una
;      subrutina SUM32, que reciba los parámetros de entrada por valor a través de la pila, y devuelva el resultado también
;      por referencia a través de la pila

org 1000h
num1baja dw 5678h
num1alta dw 1234h
num2baja dw 5678h
num2alta dw 1234h
resbaja dw ?
resalta dw ?

org 3000h
SUM32: mov bx, sp
       add bx, 2
       mov dx, [bx] ; Tomo num2baja
       add bx, 2
       mov cx, [bx] ; Tomo num2alta
       add bx, 2
       mov ax, [bx] ; Tomo num1baja
       add ax, dx   ; DX queda libre para usar, ya que sume su parte y guarde en AX, y BX uso para mover
       add bx, 2    ; BX lo estoy usando para moverme en la pila
       mov dx, [bx] ; Tomo num1alta
       adc cx, dx   ; CX tiene resultado parte alta, AX resultado parte baja
       add bx, 2    ; Tomo resalta
       mov dx, bx
       mov bx, [bx]
       mov [bx], CX
       mov bx, dx
       add bx, 2
       mov bx, [bx]
       mov [bx], AX
       ret
       
org 2000h
mov bx, offset resbaja
push bx
mov bx, offset resalta
push bx
mov bx, num1alta
push bx
mov bx, num1baja
push bx
mov bx, num2alta
push bx
mov bx, num2baja
push bx
call SUM32
pop bx
pop bx
pop bx
pop bx
pop bx
pop bx
hlt
end
