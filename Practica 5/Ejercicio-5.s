5)  El procesador MIPS64 posee 32 registros, de 64 bits cada uno, llamados r0 a r31 (también conocidos como $0 a $31).
    Sin embargo, resulta más conveniente para los programadores darles nombres más significativos a esos registros.
    La siguiente tabla muestra la convención empleada para nombrar a los 32 registros mencionados:


                Registros     Nombres           ¿Para que se los utiliza?                                                 ¿Preservado?
               -----------------------------------------------------------------------------------------------------------------------
                  r0          $zero             Constante 0, no se cambia
                  r1          $at               Reservado para uso del ensamblador
                  r2-r3       $v0-$v1           Valor retornado por subrutina
                  r4-r7       $a0-$a3           Argumentos para una subrutina
                  r8-r15      $t0-$t7           Temporarios para subrutina, no son conservados en llamado
                  r16-r23     $s0-$s7           Variables de subrutinas, salvar sus valores en llamada                      SI
                  r24-r25     $t8-$t9           Temporarios para subrutina, no son conservados en llamado
                  r26-r27     $k0-$k1           Usados por manejador de interrupciones/trap
                  R28         $gp               Global pointer, puntero global (acceso a var static/extern)                 SI
                  R29         $sp               Stack pointer, puntero de tope de pila                                      SI
                  R30         $fp               Frame pointer, puntero al marco actual de la pila                           SI
                  R31         $ra               Return address, direccion de retorno de subrutina                           SI



    Complete la tabla anterior explicando el uso que normalmente se le da cada uno de los registros nombrados. Marque
    en la columna “¿Preservado?” si el valor de cada grupo de registros debe ser preservado luego de realizada una
    llamada a una subrutina. Puede encontrar información útil en el apunte “Programando sobre MIPS64”. 
