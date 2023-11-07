1) Simular el siguiente programa de suma de números en punto flotante y analizar minuciosamente la ejecución paso a
   paso. Inhabilitar Delay Slot y mantener habilitado Forwarding.

   .data
n1: .double 9.13
n2: .double 6.58
res1: .double 0.0
res2: .double 0.0

   .code
l.d f1, n1(r0)
l.d f2, n2(r0)
add.d f3, f2, f1
mul.d f4, f2, f1
s.d f3, res1(r0)
s.d f4, res2(r0)
halt

a) Tomar nota de la cantidad de ciclos, instrucciones y CPI luego de la ejecución del programa.
   Ciclos= 16, Instrucciones= 7, CPI= 2,286

b) ¿Cuántos atascos por dependencia de datos se generan? Observar en cada caso cuál es el dato en conflicto y las
instrucciones involucradas.
   Se generan 4 atascos por dependencia de datos, esto es dado a las instrucciones ADD.D y MUL.D que tienen 
   diferentes tiempos de ejecucion a las instrucciones normales y al querer usar los datos generados, todavia
   no estan por ejemplo al querer guardarlo en memoria

c) ¿Por qué se producen los atascos estructurales? Observar cuales son las instrucciones que los generan y en qué
etapas del pipeline aparecen.
   Los atascos estructurales se producen por problemas con el uso de recursos, quizas 2 instrucciones estan en un
   mismo ciclo, dado a que una instruccion tardo mas que otra en ejecutarse y cuando llego a una etapa por ejemplo
   de guardado en memoria, justo otra instruccion que tardo menos llego tambien y ambas estan queriendo usar la
   memoria. Por ejemplo en el codigo de arriba, ocurre con la instruccion ADD.D y S.D dado a que la instruccion
   ADD.D tarda mas su ejecicion por la suma de punto flotante, y cuando pasa a escribir a memoria, S.D tambien 
   llego a esa etapa en ese momento y tiene un atasco estructural, dado a que no le falta datos, tiene todo lo
   necesario, pero no puede utilizar el recurso de la memoria

d) Modificar el programa agregando la instrucción mul.d f1, f2, f1 entre las instrucciones add.d y mul.d.
Repetir la ejecución y observar los resultados. ¿Por qué aparece un atasco tipo WAR?
   Porque esta queriendo escribir sobre un registro que otra instruccion anterior, todavia no leyo y que
   lo necesita. Dado a que la instruccion anterior tuvo un atasco RAW por dependencia de dato, se demoro
   en leer el registro que estoy necesitando escribir y por eso el atasco

e) Explicar por qué colocando un NOP antes de la suma, se soluciona el RAW de la instrucción ADD y como
consecuencia se elimina el WAR. 
