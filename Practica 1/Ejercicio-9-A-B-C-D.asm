;  9) Subrutinas para realizar rotaciones

;  A)  Escribir una subrutina ROTARIZQ que haga una rotación hacia la izquierda de los bits de un byte almacenado en la
;      memoria. Dicho byte debe pasarse por valor desde el programa principal a la subrutina a través de registros y por
;      referencia. No hay valor de retorno, sino que se modifica directamente la memoria.
;      Una rotación a izquierda de un byte se obtiene moviendo cada bit a la izquierda, salvo por el último que se mueve a la
;      primera posición. Por ejemplo al rotar a la izquierda el byte 10010100 se obtiene 00101001, y al rotar a la izquierda
;      01101011 se obtiene 11010110.
;      Para rotar a la izquierda un byte, se puede multiplicar el número por 2, o lo que es lo mismo sumarlo a sí mismo. Por
;      ejemplo (verificar):
       01101011
     + 01101011
       ________
       11010110 (CARRY=0)

;      Entonces, la instrucción add ah, ah permite hacer una rotación a izquierda. No obstante, también hay que tener en
;      cuenta que si el bit más significativo es un 1, el carry debe llevarse al bit menos significativo, es decir, se le debe sumar
;      1 al resultado de la primera suma.
       10010100
     + 10010100
       ________
       00101000 (CARRY=1)
     + 00000001
       ________
       00101001 

org 1000h
valor db 10010100b

org 3000h
ROTARIZQ: mov ah, [bx]
          add ah, [bx]
          adc ah, 0
          mov [bx], ah
          ret

org 2000h
mov bx, offset valor
call ROTARIZQ
hlt
end

-------------------------------------------------------------------------------------------------------------------------------------------

;  B)  Usando la subrutina ROTARIZQ del ejercicio anterior, escriba una subrutina ROTARIZQ_N que realice N
;      rotaciones a la izquierda de un byte. La forma de pasaje de parámetros es la misma, pero se agrega el parámetro N
;      que se recibe por valor y registro. Por ejemplo, al rotar a la izquierda 2 veces el byte 10010100, se obtiene el byte
;      01010010. 

org 1000h
valor db 10010100b
cantidad db 0h

org 3000h
ROTARIZQ: mov ah, [bx]
          add ah, [bx]
          adc ah, 0
          mov [bx], ah
          ret

ROTARIZQ_N: push dx
            loop: cmp cl, 0
            jz FIN
            call ROTARIZQ
            dec cl
            jmp loop
            fin: pop dx
                 ret 

org 2000h
mov bx, offset valor
mov cl, cantidad
call ROTARIZQ_N
hlt
end

--------------------------------------------------------------------------------------------------------------------------------------------

;  C)  Usando la subrutina ROTARIZQ_N del ejercicio anterior, escriba una subrutina ROTARDER_N que sea similar
;      pero que realice N rotaciones hacia la derecha.
;      Una rotación a derecha de N posiciones, para un byte con 8 bits, se obtiene rotando a la izquierda 8 - N posiciones. Por
;      ejemplo, al rotar a la derecha 6 veces el byte 10010100 se obtiene el byte 01010010, que es equivalente a la rotación a
;      la izquierda de 2 posiciones del ejemplo anterior. 

org 1000h
valor db 10010100b
cantidad db 6h

org 3000h
ROTARIZQ: mov ah, [bx]
          add ah, [bx]
          adc ah, 0
          mov [bx], ah
          ret

ROTARIZQ_N: push dx
            loop: cmp cl, 0
            jz fin
            call ROTARIZQ
            dec cl
            jmp loop
            fin: pop dx
                 ret 

ROTARDER_N: cmp cl, 0 ; La cantidad de rotaciones no se de ser 0
            jz finder
            cmp cl, 8 ; La cnatidad de rotaciones no sea 8 porque seria 0 | 8-8=0  
            jz finder
            cmp cl, 9 ; La cantidad de rotaciones no debe ser mayor a 8
            jns finder
            mov ch, 8
            sub ch, cl
            mov cl, ch
            call ROTARIZQ_N
            finder: ret
                     
org 2000h
mov bx, offset valor
mov cl, cantidad
call ROTARDER_N
hlt
end

--------------------------------------------------------------------------------------------------------------------------

;  D)   Escriba la subrutina ROTARDER del ejercicio anterior, pero sin usar la subrutina ROTARIZ. Compare qué ventajas
;       tiene cada una de las soluciones.

org 1000h
valor db 10010100b
cantidad db 6h

org 3000h
ROTARIZQ: mov ah, [bx]
          add ah, [bx]
          adc ah, 0
          mov [bx], ah
          ret

ROTARDER_N: cmp cl, 0 ; La cantidad de rotaciones no se de ser 0
            jz finder
            cmp cl, 8 ; La cnatidad de rotaciones no sea 8 porque seria 0 | 8-8=0  
            jz finder
            cmp cl, 9 ; La cantidad de rotaciones no debe ser mayor a 8
            jns finder
            mov ch, 8
            sub ch, cl
            mov cl, ch
            loop: cmp cl, 0 
            jz finder
            call ROTARIZQ
            dec cl
            jmp loop
            finder: ret
                     
org 2000h
mov bx, offset valor
mov cl, cantidad
call ROTARDER_N
hlt
end

; La ventaja que tiene usar ROTARIZQ_N es que de divide mas el codigo y se subdivide las funciones, el rotar a la derecha y el rotar a la izquierda, teniendo todo en la rotar a la derecha
; genera mas confusion porque hace dos cosas, y por lo tanto se entiende menos
