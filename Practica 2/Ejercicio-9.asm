;  9)  Escribir un programa que aguarde el ingreso de una clave de cuatro caracteres por teclado sin
;  visualizarla en pantalla. En caso de coincidir con una clave predefinida (y guardada en memoria) 
;  que muestre el mensaje "Acceso permitido", caso contrario el mensaje "Acceso denegado". 

org 1000h
clave_guardada db "1234"
acceso_permitido db "Acceso Permitido"
acceso_denegado db "Acceso Denegado"
fin db ?

org 1500h
clave_ingresada db ?
                db ?
                db ?
                db ?

org 2000h
mov bx, offset clave_ingresada
int 6
mov ah, 3
loop_ingresar: inc bx
               int 6
               dec ah
               cmp ah, 0
               jnz loop_ingresar
mov cx, offset clave_guardada
mov dx, offset clave_ingresada
mov ah, 4
loop: mov bx, cx
      mov al, [bx]
      mov bx, dx
      cmp al, [bx]
      jnz finAD
      dec ah
      cmp ah, 0
      jz finAP
      inc dx
      inc cx
      jmp loop
finAP: mov bx, offset acceso_permitido
       mov al, offset acceso_denegado - offset acceso_permitido 
       int 7
       jmp fin_pro
finAD: mov bx, offset acceso_denegado
       mov al, offset fin -  offset acceso_denegado 
       int 7
fin_pro: int 0
end
