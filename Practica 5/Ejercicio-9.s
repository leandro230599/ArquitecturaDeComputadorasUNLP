;   Escriba la subrutina ES_VOCAL que determina si un caracter es vocal o no, ya sea mayúscula o minúscula. La
;   rutina debe recibir el caracter y debe retornar el valor 1 si es una vocal ó 0 en caso contrario. 

.data 
vocales: .asciiz "aeiouAEIOU"
caracter: .ascii "U"

.code
daddi $s0, $zero, vocales                           ; Le paso a $s0 la direccion de vocales
lbu $a0, caracter($zero)                            ; Cargo en $a0 el caracter a ver si es vocal o no
jal subrutina                                       ; Llamo a la subrutina
halt
subrutina: daddi $v0, $zero, 0                      ; La variable de retorno la seteo en 0
           dadd $t0, $a0, $zero                     ; En $t0 guardo el caracter a ver si es vocal o no
           lbu $t1, 0($s0)                          ; Guardo en $t1 el primer caracter de las vocales
           loop: beqz $t1, fin                      ; Verifico que $t1 no sea 0, si lo es salta a fin
                 bne $t1, $t0, siguiente            ; Si no son iguales $t1 y $t0 anda a siguiente,
                 daddi $v0, $zero, 1                ; $t1 y $t0 son iguales entonces sumale 1 a $v0
                 siguiente: daddi $s0, $s0, 1       ; Suma 1 a $s0 que tiene la direccion de las vocales, es byte
                            lbu $t1, 0($s0)         ; Cargo en $t1 el siguiente caracter de la tabla
                            j loop                  ; Salto incondicional a loop
           fin: jr $ra                              ; Termina la subrutina y vuelve a la siguiente direccion del llamado
