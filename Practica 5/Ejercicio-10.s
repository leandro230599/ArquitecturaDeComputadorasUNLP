;   Usando la subrutina escrita en el ejercicio anterior, escriir la subrutina CONTAR_VOC, que recibe una cadena
;   terminada en cero y devuelve la cantidad de vocales que tiene esa cadena. 

.data
cadena: .asciiz "la"
vocales: .asciiz "aeiou"
result: .word 0

.code
daddi $a0, $0, cadena
jal CONTAR_VOC
sd $v0, result($0)
halt

CONTAR_VOC: daddi $v0, $0, 0
    volver: lbu $t2, 0($a0)
            beqz $t2, fin
            daddi $t0, $zero, 0

    loop:   lbu $t1, vocales($t0)
            beqz $t1, fin_vocal
            beq $t2, $t1, si_es
            daddi $t0, $t0, 1
            j loop

    si_es:  daddi $v0, $v0, 1
fin_vocal:  daddi $a0, $a0, 1
            j volver

fin:        jr $ra