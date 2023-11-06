7) Escribir un programa que recorra una TABLA de diez números enteros y determine cuántos elementos son mayores que X.
El resultado debe almacenarse en una dirección etiquetada CANT. El programa debe generar además otro arreglo llamado RES
cuyos elementos sean ceros y unos. Un ‘1’ indicará que el entero correspondiente en el arreglo TABLA es mayor que X,
mientras que un ‘0’ indicará que es menor o igual.

    .data
TABLA: .word 10, 26, 24, 30, 20, 50, 15, 27, 12, 78
NUM: .word 25
CANT: .word 0
TOTAL: .word 10
DESPLAZAMIENTO: .word 0
RES: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

    .code
lw r1, NUM(r0) 	; R1 almacenara el valor NUM que es el que se debe comparar
lw r2, CANT(r0) ; R2 almacenara el valor de CANT que es el total
lw r3, TOTAL(r0); R3 almacenara el valor de TOTAL que es la cantidad que se debe iterar
lw r4, DESPLAZAMIENTO(r0) ; R4 almacenara el valor de DESPLAZAMIENTO que es la cantidad de bits a desplazarse
daddi r10, r10, 1 ; R10 almacenara el 1 que sera para comparar mayor o menor
loop: beqz r3, fin
	  lw r5, TABLA(r4) ; R5 almacenara el valor actual de la TABLA segun el desplazamiento de R4
	  slt r6, r1, r5 
	  bne r10, r6, fin_loop
	  daddi r2, r2, 1
	  sw r10, RES(r4)
	  fin_loop: daddi r4, r4, 8
				daddi r3, r3, -1
				j loop
fin: sw r2, CANT(r0) 
halt
