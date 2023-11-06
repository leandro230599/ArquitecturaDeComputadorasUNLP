6) Escribir un programa que lea tres números enteros A, B y C de la memoria de datos y determine cuántos de ellos son iguales
entre sí (0, 2 o 3). El resultado debe quedar almacenado en la dirección de memoria D. 

    .data
A: .word 1
B: .word 2
C: .word 3
D: .word 0

    .code
lw r1, A(r0)
lw r2, B(r0)
lw r3, C(r0)
lw r4, D(r0)
daddi r5, r0, 2
bne r1, r2, caso2
daddi r4, r4, 1
caso2: bne r1, r3, caso3
daddi r4, r4, 1
bne r4, r5, caso3
daddi r4, r4, 1
j fin
caso3: bne r2, r1, caso4
daddi r4, r4, 1
j fin
caso4: bne r3, r1, caso5
daddi r4, r4, 1
j fin
caso5: bne r2, r3, fin
daddi r4, r4, 2 
fin: sw r4, D(r0)
halt
