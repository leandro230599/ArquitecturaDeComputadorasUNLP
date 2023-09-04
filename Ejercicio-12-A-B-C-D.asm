;  12) Analizar el funcionamiento de la siguiente subrutina y su programa principal:

ORG 3000H
MUL: CMP AX, 0
JZ FIN
ADD CX, AX
DEC AX
CALL MUL
FIN: RET

ORG 2000H
MOV CX, 0
MOV AX, 3
CALL MUL
HLT
END

;  A)  ¿Qué hace la subrutina?

La subrutina lo que hace es una sumatoria

-----------------------------------------------------------------------------------------------------------------------------

;  B)  ¿Cuál será el valor final de CX?

El valor final de CX sera 0006

-----------------------------------------------------------------------------------------------------------------------------

;  C)  Dibujar las posiciones de memoria de la pila, anotando qué valores va tomando

Imagen adjunta afuera 12C.png

-----------------------------------------------------------------------------------------------------------------------------

;  D)  ¿Cuál será la limitación para determinar el valor más grande que se le puede pasar a la subrutina a través de AX? 

La limitacion que tiene es la cantidad de byte que puede manejar el registro, dado a que es 2 bytes, en hexadecimal el valor mas alto que se le puede
pasar es FFFFh
