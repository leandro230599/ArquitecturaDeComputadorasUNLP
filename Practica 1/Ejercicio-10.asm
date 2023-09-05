;  10) SWAP 
;      Escribir una subrutina SWAP que intercambie dos datos de 16 bits almacenados en memoria. Los
;      parámetros deben ser pasados por referencia desde el programa principal a través de la pila.
;      Para hacer este ejercicio, tener en cuenta que los parámetros que se pasan por la pila son las direcciones de memoria,
;      por lo tanto para acceder a los datos a intercambiar se requieren accesos indirectos, además de los que ya se deben
;      realizar para acceder a los parámetros de la pila.

org 1000h
dato1 dw 1234h
dato2 dw 5678h

org 3000h
SWAP: mov bx, sp
      add bx, 2
      push bx
      mov cx, [bx]
      mov bx, cx
      mov cx, [bx]
      pop bx
      add bx, 2
      mov dx, [bx]
      mov bx, dx
      mov dx, [bx]
      mov [bx], cx
      add bx, 2
      mov [bx], dx
      ret
                     
org 2000h
mov bx, offset dato1
push bx
mov bx, offset dato2
push bx
call SWAP
hlt
end
