; 6)  Escribir un programa que solicite el ingreso de un número (de un dígito) por teclado y 
;     muestre en pantalla dicho número expresado en letras. Luego que solicite el ingreso de otro
;     y así sucesivamente. Se debe finalizar la ejecución al ingresarse en dos vueltas consecutiva
;     el número cero. 

org 1000h
numeros db "Cero  "
        db "Uno   "
        db "Dos   "
        db "Tres  "
        db "Cuatro"
        db "Cinco "
        db "Seis  "
        db "Siete "
        db "Ocho  "
        db "Nueve "
mensaje db "In: "
fin db ?

org 1500h
num db ?

org 2000h
mov cx, 0
loop_principal:  mov bx, offset mensaje
                 mov al, offset fin - offset mensaje
                 int 7
                 mov bx, offset num
                 int 6
       checkeo:  cmp num, 30h
                 js fin_program
                 cmp num, 3Ah
                 jns fin_program
                 cmp num, 30h
                 jz es_cero
                 mov cx, 0
                 mov bx, offset numeros
                 mov al, 6
 loop_busqueda:  cmp num, 30h
                 jz imprime
                 dec num
                 add bx, 6
                 jmp loop_busqueda
       imprime:  int 7
                 jmp loop_principal
       es_cero:  inc cx
                 cmp cx, 2
                 jz fin_program
                 jmp loop_principal
   fin_program:  int 0
end
