A)

          ORG 1000h
            A dw 5h
            B dw 6h
            C dw 2h
            D dw ?
          
          org 2000h
            mov ax, A
            add ax, B
            sub ax, C
            mov bx, offset D
            mov [bx], ax
            hlt
          end

------------------------------------------------------
B)
        ORG 1000h
          A dw 5h
          B dw 6h
          C dw 2h
          D dw ?
        
        ORG 2000h
          call calculo
          hlt
        
        ORG 3000h
        calculo:   mov ax, A
                   add ax, B
                   sub ax, C
                   mov bx, offset D
                   mov [bx], ax
                   ret
        end

------------------------------------------------------
C)

        ORG 1000h
          A dw 5h
          B dw 6h
          C dw 2h
          D dw ?
        
        ORG 2000h
          mov ax, A
          mov bx, B
          mov cx, C
          call calculo
          mov bx, offset D
          mov [bx], dx
          hlt
        
        ORG 3000h
        calculo:   add ax, bx
                   sub ax, cx
                   mov dx, ax
                   ret
        end

------------------------------------------------------
D)
; Las del inciso B no se podrian reutilizar dado a que la carga se hace en la rutina, y el C si se puede reutilizar porque la carga se hace en el programa principal y le pasa el argumento de lo que tiene que utilizar
