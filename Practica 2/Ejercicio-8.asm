;  8)  Escribir un programa que efectúe la resta de dos números (de un dígito cada uno) 
;      ingresados por teclado y muestre el resultado en la pantalla de comandos. Antes de
;      visualizarlo el programa debe verificar si el resultado es positivo o negativo
;      y anteponer al valor el signo correspondiente. 


org 1000h
num1 db ?
num2 db ?
signo db "+" ; El "-" esta dos caracteres ascii adelante osea "+" + 2
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
sub cl, [bx]
jns imprimir
add signo, 2h
mov bx, offset num1
mov ch, [bx]
mov bx, offset num2
mov cl, [bx]
sub cl, ch
imprimir: mov res, cl
add res, 30h
mov bx, offset signo
mov al, 2
int 7
int 0
end
