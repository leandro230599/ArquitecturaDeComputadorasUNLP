7)  Escriba una subrutina que reciba como parámetros un número positivo M de 64 bits, la dirección del comienzo de una
    tabla que contenga valores numéricos de 64 bits sin signo y la cantidad de valores almacenados en dicha tabla.
    La subrutina debe retornar la cantidad de valores mayores que M contenidos en la tabla. 


.data
tabla:  .word   20, 25, 30, 35, 40, 45

.code
    lw      $a0,        tabla($0)                               ; Direccion de la tabla
    daddi   $a1,        $0,         34                          ; El numero positivo a comparar
    daddi   $a2,        $0,         6                           ; Cantidad de valores en la tabla
    jal     subrutina                                           ; Salto a la subrutina y guarda retorno en $ra
    halt    
subrutina:    daddi   $v0,        $zero,        0               ; Inicio de la subrutina, settea en $v0 (R2) 0 que sera el retorno de la subrutina
    daddi   $t0,        $zero,      0                           ; Setea la variable temporal $t0 en 0 que sera usada para desplazamiento
loop:       beqz    $a2,        fin                             ; Si $a2 no llego a 0, continua sino salta a fin
            slt     $t1,        $a1,        $a0                 ; Compara si $a1 osea 29 es menor al valor actual en la tabla que esta en $a0, si 29 es menor pone $t1 en 1
            beqz    $t1,        avanza                          ; Si $t1 es 0, salta a avanza, sino continua
            daddi   $v0,        $v0,        1                   ; Suma al $v0 que es el retorno, 1 porque 29 es menor que el valor actual de la tabla
            avanza:     daddi   $a2,        $a2,        -1      ; Resta 1 a $a2 que seria el total de valores restantes a comparar en la tabla
                        daddi   $t0,        $t0,        8       ; Suma 8 a $t0 que seria el desplazamiento
                        lw      $a0,        tabla($t0)          ; Carga en $a0 el valor actual de la tabla sumandole el desplazamiento
                        j       loop                            ; Salto incondicional al loop
fin:        jr      $ra                                         ; Finalizo porque ya comparo todos los elementos de la tabla y vuelve a la siguiente instruccion del llamado a la subrutina
