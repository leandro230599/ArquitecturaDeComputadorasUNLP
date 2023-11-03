3) Analizar el siguiente programa con el simulador MIPS64:

 .data
A: .word 1
B: .word 3
 .code
 ld r1, A(r0)
 ld r2, B(r0)
loop: dsll r1, r1, 1
 daddi r2, r2, -1
 bnez r2, loop
halt

a) Ejecutar el programa con Forwarding habilitado y responder:

  - ¿Por qué se presentan atascos tipo RAW?
        Se producen atascos RAW porque hay instruccion de salto, y esta se procesa en ID, por lo cual
        aunque este activado el forwarding, los saltos se procesan en esa etapa
  
  - Branch Taken es otro tipo de atasco que aparece. ¿Qué significa? ¿Por qué se produce?
        Branch Taken Stall (BTS) o Atasco Branch Taken, es un atasco que aparece al no ejecutarse la siguiente
        instruccion a una instruccion condicional, porque la instruccion siguiente al condicional, se cargara
        en el pipeline, pero si hay salto o algo asi y no toca ejecutarla, se la mata y queda ahi nomas la
        instruccion y se ejecuta la que deba ir
  
  - ¿Cuántos CPI tiene la ejecución de este programa? Tomar nota del número de ciclos, cantidad de instrucciones y CPI.
        1,750 con 21 ciclos y 12 instrucciones
  
b) Ejecutar ahora el programa deshabilitando el Forwarding y responder:

  - ¿Qué instrucciones generan los atascos tipo RAW y por qué? ¿En qué etapa del cauce se produce el atasco en cada caso y
  durante cuántos ciclos?
        El primer atasco en la instruccion DSLL porque no fue escrito en el registro el valor a leer, se produjo en el ciclo
        ID y 1 ciclo de mas duro
        El segundo, tercero y cuarto atasco en la instruccion BNEZ porque lee el registro y ve si salta pero no fue escrito 
        aun, se produce en ID y 2 ciclos de mas duro
  
  - Los Branch Taken Stalls se siguen generando. ¿Qué cantidad de ciclos dura este atasco en cada vuelta del lazo ‘loop’?
  Comparar con la ejecución con Forwarding y explicar la diferencia.
        Dura 3 ciclos, seria 2 de mas, en cada vuelta del lazo loop, a diferencia de usar forwarding, que dura 2 ciclos,
        osea 1 de mas, esta diferencia es porque esta ligado a la duracion de la etapa ID de la instruccion condicional,
        que al terminar de ejecutarse esa etapa es que sabe si saltara o no, y como al no haber forwarding, el ID tarda mas
        el IF terminara tardando mas, y al haber forwarding el ID tarda menos y el IF terminara tardando menos
  
  - ¿Cuántos CPI tiene la ejecución del programa en este caso? Comparar número de ciclos, cantidad de instrucciones y CPI
  con el caso con Forwarding.
        2,083 CPI con 25 ciclos y 12 instrucciones
  
c) Reordenar las instrucciones para que la cantidad de RAW sea ‘0’ en la ejecución del programa (Forwarding habilitado)

 .data
A: .word 1
B: .word 3
 .code
 ld r2, B(r0)
 ld r1, A(r0)
loop: daddi r2, r2, -1
 dsll r1, r1, 1
 bnez r2, loop
halt 


d) Modificar el programa para que almacene en un arreglo en memoria de datos los contenidos parciales del registro r1 ¿Qué
significado tienen los elementos de la tabla que se genera? 
