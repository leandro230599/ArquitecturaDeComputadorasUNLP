6)  Como ya se observó anteriormente, muchas instrucciones que normalmente forman parte del repertorio de un
    procesador con arquitectura CISC no existen en el MIPS64. En particular, el soporte para la invocación a subrutinas
    es mucho más simple que el provisto en la arquitectura x86 (pero no por ello menos potente). El siguiente programa
    muestra un ejemplo de invocación a una subrutina.
    
 .data
valor1: .word 16
valor2: .word 4
result: .word 0

 .text
ld $a0, valor1($zero)
ld $a1, valor2($zero)
jal a_la_potencia
sd $v0, result($zero)
halt
a_la_potencia: daddi $v0, $zero, 1
 lazo: slt $t1, $a1, $zero
bnez $t1, terminar
daddi $a1, $a1, -1
dmul $v0, $v0, $a0
j lazo
 terminar: jr $ra

 
a) ¿Qué hace el programa? ¿Cómo está estructurado el código del mismo?
      Calcula el resultado de un numero A elevado a un numero B, esta estructurado con subrutinas para los
      calculos

b) ¿Qué acciones produce la instrucción jal? ¿Y la instrucción jr?
      JAL= Salta a la direccion de la etiqueta y guarda en R31 o $ra la direccion de retorno
      JR= Salta a la direccion contenida en el registro pasado

c) ¿Qué valor se almacena en el registro $ra? ¿Qué función cumplen los registros $a0 y $a1? ¿Y el registro $v0?
      Se almacena la direccion de retorno, a donde debe volver al salir de la subrutina, que parte del programa.
      Los registros $a0 y $a1 cumplen la funcion de ser argumentos que son pasados a la subrutina.
      El registro $v0 cumple la funcion de ser el valor de retorno de la subrutina

d) ¿Qué sucedería si la subrutina a_la_potencia necesitara invocar a otra subrutina para realizar la multiplicación,
por ejemplo, en lugar de usar la instrucción dmul? ¿Cómo sabría cada una de las subrutinas a que dirección de
memoria deben retornar? 
      
