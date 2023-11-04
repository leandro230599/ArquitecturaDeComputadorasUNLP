4)   Dado el siguiente programa:
  .data
tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
num: .word 7
long: .word 10

  .code
ld r1, long(r0)
ld r2, num(r0)
dadd r3, r0, r0
dadd r10, r0, r0
loop: ld r4, tabla(r3)
      beq r4, r2, listo
      daddi r1, r1, -1
      daddi r3, r3, 8
      bnez r1, loop
      j fin
listo: daddi r10, r0, 1
fin: halt

a) Ejecutar en simulador con Forwarding habilitado. ¿Qué tarea realiza? ¿Cuál es el resultado y dónde queda indicado?
      Busca el valor de la variable "num", la cual tiene almacenado el 7, busca ese valor en el arreglo "tabla", si lo 
      encuentra, en R10 se guardara un 1, sino se guardara un 0, en este caso si tiene un 7 el arreglo asi que quedara un 1

b) Re-Ejecutar el programa con la opción Configure/Enable Branch Target Buffer habilitada. Explicar la ventaja de usar este
método y cómo trabaja.
      

c) Confeccionar una tabla que compare número de ciclos, CPI, RAWs y Branch Taken Stalls para los dos casos anteriores.
