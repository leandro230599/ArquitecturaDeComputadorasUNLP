;   Escriba una subrutina que reciba como parámetros las direcciones del comienzo de dos cadenas terminadas en cero y
;   retorne la posición en la que las dos cadenas difieren. En caso de que las dos cadenas sean idénticas, debe retornar -1. 

.data
cadena1: .asciiz "hola"
cadena2: .asciiz "hola"

.code
daddi $sp,  $zero,  0x400                           ; Le paso a $sp el valor tope de la pila
daddi $a0, $zero, cadena1                           ; Le paso a $a0 que es un argumento de subrutina, el inicio de cadena1
daddi $a1, $zero, cadena2                           ; Le paso a $a1 que es un argumento de subrutina, el inicio de cadena2
jal subrutina                                       ; Llamo a la subrutina y se guarda en $ra la direccion de la siguiente instruccion
halt
subrutina: daddi $sp, $sp, -8                       ; Push del $ra
           sd $ra, 0($sp)                           ; Push del $ra
           daddi $t0, $a0, 0                        ; Le paso a la variable temporal $t0 el valor del argumento $a0 que seria la referencia a la cadena1
           jal contar_cadena                        ; Llamo a la subrutina contar_cadena
           daddi $t3, $v0, 0                        ; Guardo en $t3 lo que contenga $v0 que tiene el retorno de contar_cadena
           daddi $t0, $a1, 0                        ; Le paso a la variable temporal $t0 el valor del argumento $a1 que seria la referencia a la cadena2
           jal contar_cadena                        ; Llamo a la subrutina contar_cadena
           daddi $t4, $v0, 0                        ; Guardo en $t4 lo que contenga $v0 que tiene el retorno de contar_cadena
           ld $ra, 0($sp)                           ; Pop del $ra
           daddi $sp, $sp, 8                        ; Pop del $ra
           dsub $v0, $t4, $t3
           slt $t5, $v0, $zero
           beqz $t5, es_zero
           dsub $v0, $t3, $t4
           es_zero: bnez $v0, fin_subrutina
           daddi $v0, $zero, -1
           fin_subrutina: jr $ra

contar_cadena: daddi $v0, $zero, 0                  ; Inicio la variable de retorno $v0 en 0
               lbu $t1, 0($t0)                      ; Guardo en $t1 el caracter de la posicion 0 + $t0 (que tiene la direccion de la cadena)
               loop_cadena: beqz $t1, fin_cadena    ; Si $t1 no es zero continua sino salta a fin_cadena
                            daddi $v0, $v0, 1       ; Como no es el fin, sumo a la variable de retorno 1
                            daddi $t0, $t0, 1       ; Sumo 1 al desplazamiento por ser byte 
                            lbu $t1, 0($t0)
                            j loop_cadena
               fin_cadena:  jr $ra
