2) El siguiente programa intercambia el contenido de dos palabras de la memoria de datos, etiquetadas A y B.

 .data
A: .word 1
B: .word 2
 .code
 ld r1, A(r0)
 ld r2, B(r0)
 sd r2, A(r0)
 sd r1, B(r0)
halt


a) Ejecutarlo en el simulador con la opción Configure/Enable Forwarding deshabilitada. Analizar paso a paso su
funcionamiento, examinar las distintas ventanas que se muestran en el simulador y responder:

  - ¿Qué instrucción está generando atascos (stalls) en el cauce (ó pipeline) y por qué?
        La instruccion que esta generando el atasco (stall) es SD R2, A(R0) dado a que en la instruccion anterior se escribio
        tal registro, por lo cual al estar el forwarding desactivado, se escribira en el registro el valor de A en la etapa WB
        y como no llego a esa etapa, se quedara en ID esperando
  
  - ¿Qué tipo de ‘stall’ es el que aparece?
        Es un atasco de dependencia de dato tipo RAW porque intenta leer algo que no fue escrito
  
  - ¿Cuál es el promedio de Ciclos Por Instrucción (CPI) en la ejecución de este programa bajo esta configuración?
        2,2 CPI, 11 ciclos 5 instrucciones

----------------------------------------------------------------------------------------------------------------------------

b) Una forma de solucionar los atascos por dependencia de datos es utilizando el Adelantamiento de Operandos o Forwarding.
Ejecutar nuevamente el programa anterior con la opción Enable Forwarding habilitada y responder:

  - ¿Por qué no se presenta ningún atasco en este caso? Explicar la mejora.
        Porque el valor esta disponible al final de la etapa MEM, no hace falta esperar a WB
        
  - ¿Qué indica el color de los registros en la ventana Register durante la ejecución?
        Que se esta escribiendo en los registros
        
  - ¿Cuál es el promedio de Ciclos Por Instrucción (CPI) en este caso? Comparar con el anterior. 
        El promedio ahora es de 1,8 que es mejor que el anterior de 2,2 CPI, ahora son 9 ciclos 5 instrucciones
