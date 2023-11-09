;   Escriba una subrutina que reciba como parámetros las direcciones del comienzo de dos cadenas terminadas en cero y
;   retorne la posición en la que las dos cadenas difieren. En caso de que las dos cadenas sean idénticas, debe retornar -1. 

.data
cadena1: .asciiz "hola"
cadena2: .asciiz "hola"

.code
daddi $sp,  $zero,  0x400
daddi $a0, $zero, cadena1
daddi $a1, $zero, cadena2
jal subrutina
halt
subrutina: daddi $v0, $zero, 0      ; Retorno de la subrutina principal
           daddi $sp, $sp, -8       ; Push del $ra
           sd $ra, 0($sp)           ; Push del $ra
           daddi $t0, $a0, 0        ; Le paso a la variable temporal $t0 el valor del argumento $a0 que seria la referencia a la cadena1
           jal contar_cadena        ; Llamo a la subrutina contar_cadena

contar_cadena: daddi $v0, $zero, 0  ; Inicio la variable de retorno $v0 en 0
               lbu $t1, 0($t0)
               loop_cadena: beqz $t0, fin_cadena    ; Si $t0 no es zero continua sino salta a fin_cadena
                            daddi $v0, $v0, 1       ; Como no es el fin, sumo a la variable de retorno 1
                            daddi $t0, $t0, 1       ; Sumo 1 al desplazamiento por ser byte 
                            lbu $t0, 
           
