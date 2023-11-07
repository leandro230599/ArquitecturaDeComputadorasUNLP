8) Escribir un programa que multiplique dos números enteros utilizando sumas repetidas (similar a Ejercicio 6 o 7 de la Práctica
   1). El programa debe estar optimizado para su ejecución con la opción Delay Slot habilitada. 

    .data
A: .word 2
B: .word 0
C: .word 0

    .code
lw r1, A(r0)
lw r2, B(r0)
lw r3, C(r0)
beqz r1, fin
loop: beqz r2, fin
	  daddi r2, r2, -1
	  j loop
	  dadd r3, r3, r1
fin: sw r3, C(r0)
halt
