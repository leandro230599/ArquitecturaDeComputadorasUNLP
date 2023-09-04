;  2)  Escribir un programa que muestre en pantalla todos los caracteres disponibles en el simulador MSX88, comenzando con
;      el caracter cuyo código es el número 01H. 

ORG 1000H
caracteres DB 01h

ORG 2000H
 MOV BX, OFFSET caracteres
 MOV AL, 1
 loop: int 7
       inc byte ptr [bx]
       cmp byte ptr[bx], 80h
       jz fin
       jmp loop
 fin:  INT 0
 END 
