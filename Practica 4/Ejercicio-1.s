;  1)  Muchas instrucciones comunes en procesadores con arquitectura CISC no forman parte del repertorio de instrucciones del
;      MIPS64, pero pueden implementarse haciendo uso de una única instrucción. Evaluar las siguientes instrucciones, indicar qué
;      tarea realizan y cuál sería su equivalente en lenguaje assembly del x86.

A) dadd r1, r2, r0
Asigna En R1, la suma entre R2 y R0, que R0 seria 0, osea en resumen asigna en R1 lo que tiene R2, DADD se usa en sumas con registros
MOV AX, CX

B) daddi r3, r0, 5
Asigna en R3, la suma entre R0 que seria 0, y 5 que es un valor inmediato, DADDI se usa para sumas entre registro y un inmediato
MOV AX, 5

C) dsub r4, r4, r4
Resta a R4, el valor de R4, y lo asigna en R4
MOV AX, 0

D) daddi r5, r5, -1
Resta a R5 el valor inmediato -1, que seria para sumar, pero al ser negativo lo resta
DEC AX

E) xori r6, r6, 0xffffffffffffffff
Hace la operacion XOR entre el registro R6 y el inmediato
XOR AX, FF
