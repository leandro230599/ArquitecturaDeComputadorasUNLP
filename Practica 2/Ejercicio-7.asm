;  7)  Escribir un programa que efectúe la suma de dos números (de un dígito cada uno) ingresados por 
;      teclado y muestre el resultado en la pantalla de comandos. Recordar que el código de cada 
;      caracter ingresado no coincide con el número que representa y que el resultado puede necesitar
;      ser expresado con 2 dígitos. 

org 1000h
num1 db ?
num2 db ?
primer_dig db "0"
res db ?

org 1500h
msj db "IN: "
fin db ?

org 2000h
mov bx, offset msj
mov al, offset fin - offset msj
int 7
mov bx, offset num1
int 6
mov bx, offset num2
int 6
sub num1, 30h
sub num2, 30h
mov cx, 0
mov bx, offset num1
mov cl, [bx]
mov bx, offset num2
add cl, [bx]
mov res, cl
add res, 30h
mov bx, offset res
int 7



end
