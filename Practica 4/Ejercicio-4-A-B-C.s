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
      La ventaja de BTB es que predice si habra salto o no, si hay salto, predice la direccion de salto, si salto o no
      la direccion de la instruccion de salto leida, esto sirve porque si tengo un loop condicional ponele de leer el 
      registro R1, que este tiene el valor 10 y se va decrementando y si no llega a 0, salte, el BTB me permite predecir que
      va a saltar y el primer caso y el ultimo fallaran leyendo la siguiente instruccion del salto y quitandose del cause,
      las demas veces predecira correctamente, en el ultimo caso, predecira que debe saltar, pero al llegar a la etapa ID
      vera que no debia saltar, por lo que la siguiente instruccion que estaba en IF, se descartara y tomara la que debia
      ejecutar

c) Confeccionar una tabla que compare número de ciclos, CPI, RAWs y Branch Taken Stalls para los dos casos anteriores.
SIN BTB: 
Ciclos: 71  Instrucciones: 43  CPI: 1,651  RAWs: 16  BTS: 8

CON BTB: 
Ciclos: 67  Instrucciones: 43  CPI: 1,558  RAWs: 16  BTS: 4


