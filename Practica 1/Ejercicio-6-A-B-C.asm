; 6)  Multiplicación de números sin signo. Pasaje de parámetros a través de registros.
;     El simulador no posee una instrucción para multiplicar números. Escribir un programa para multiplicar los números
;     NUM1 y NUM2, y guardar el resultado en la variable RES

; A)  Sin hacer llamados a subrutinas, resolviendo el problema desde el programa principal

      ORG 1000h
        NUM1 dw 5h
        NUM2 dw 2h
        RES  dw ?
      
      ORG 2000h
        mov ax, 0
        cmp NUM2, 0h ; Comprueba que NUM2 no sea 0
        jz fin
        cmp NUM1, 0h ; Comprueba que NUM1 no sea 0
        jz fin
        multiplicacion: add ax, NUM1
                        dec NUM2
                        jnz multiplicacion
        fin:  mov RES, ax
              hlt
      end

----------------------------------------------------------------

; B)  Llamando a una subrutina MUL para efectuar la operación, pasando los parámetros por valor desde el programa
      principal a través de registros y devolviendo el resultado a través de un registro por valor.


      ORG 1000h
          NUM1 dw 5h
          NUM2 dw 2h
          RES  dw ?
        
        ORG 2000h
          mov ax, NUM1
          mov bx, NUM2
          call mul
          mov RES, cx
          hlt
        
        ORG 3000h
        mul: mov cx, 0
             cmp ax, 0h
             jz fin
             cmp bx, 0h
             jz fin
             multiplicacion: add cx, ax
                             dec bx
                             jnz multiplicacion
             fin: ret
        end

-----------------------------------------------------------------

; C)  Llamando a una subrutina MUL, pasando los parámetros por referencia desde el programa principal a través de
;     registros, y devolviendo el resultado a través de un registro por valor.

        ORG 1000h
          NUM1 dw 4h
          NUM2 dw 2h
          RES  dw ?
        
        ORG 2000h
          mov ax, offset NUM1
          mov cx, offset NUM2
          call mul
          mov RES, dx
          hlt
        
        ORG 3000h
        mul: mov bx, ax
             mov ax, [bx]
             mov bx, cx
             mov cx, [bx]
             mov dx, 0
             cmp ax, 0h
             jz fin
             cmp cx, 0h
             jz fin
             multiplicacion: add dx, ax
                             dec cx
                             jnz multiplicacion
             fin: ret
        end

