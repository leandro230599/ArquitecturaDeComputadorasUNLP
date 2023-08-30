A)

      ORG 1000h
        NUM1 dw 5h
        NUM2 dw 2h
        RES  dw ?
      
      ORG 2000h
        mov ax, 0
        mov cx, NUM2
        multiplicacion: add ax, NUM1
                        dec cx
                        jnz multiplicacion
        mov RES, ax
        hlt
      end

----------------------------------------------------------------

B)


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
             multiplicacion: add cx, ax
                             dec bx
                             jnz multiplicacion
             ret
        end

-----------------------------------------------------------------

C)

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
             multiplicacion: add dx, ax
                             dec cx
                             jnz multiplicacion
             ret
        end

