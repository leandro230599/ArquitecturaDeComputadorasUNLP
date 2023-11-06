5) El siguiente programa multiplica por 2 los elementos de un arreglo llamado datos y genera un nuevo arreglo llamado res.
Ejecutar el programa en el simulador winmips64 con la opción Delay Slot habilitada.

    .data
cant: .word 8
datos: .word 1, 2, 3, 4, 5, 6, 7, 8
res: .word 0

    .code
dadd r1, r0, r0
ld r2, cant(r0)
loop: ld r3, datos(r1)
      daddi r2, r2, -1
      dsll r3, r3, 1
      sd r3, res(r1)
      daddi r1, r1, 8
      bnez r2, loop
      nop
halt

A) ¿Qué efecto tiene habilitar la opción Delay Slot (salto retardado)?.
      El efecto de habilitar la opcion Delay Slot (salto retardado), es que ejecuta la siguiente instruccion a un salto
      por lo cual independientemente de si salte o no, ejecutara la siguiente opcion al salto, por lo cual es recomendable
      acomodar las instrucciones poniendo luego del salto, alguna opcion que no afecte el funcionamiento o una
      instruccion NOP,

b) ¿Con qué fin se incluye la instrucción NOP? ¿Qué sucedería si no estuviera?.
      Dado a que la instruccion NOP no hace nada por eso se la incluye, si no estuviera, ejecutaria el HALT y terminaria
      toda la ejecucion
  
c) Tomar nota de la cantidad de ciclos, la cantidad de instrucciones y los CPI luego de ejecutar el programa.
      Ciclos: 63, Instrucciones: 59, CPI: 1.068

d) Modificar el programa para aprovechar el ‘Delay Slot’ ejecutando una instrucción útil. Simular y comparar número de
ciclos, instrucciones y CPI obtenidos con los de la versión anterior. 
      Acomodo el daddi que esta antes del salto para despues, y elimino el nop
      Ciclos: 55, Instrucciones: 51, CPI: 1.078
