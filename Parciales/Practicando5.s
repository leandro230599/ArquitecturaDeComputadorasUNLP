.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
cad_msg: .asciiz "Cadena con reemplazos: "
minu_msg: .asciiz "Letras convertidas a minuscula: "
A: .asciiz "CadeNA <-enTRADa->!!!"
B: .asciiz ""

.code
daddi $sp, $0, 0x400
lwu $s0, CONTROL($0)
lwu $s1, DATA($0)
daddi $a0, $0, A
daddi $a1, $0, B
jal procesar_cadena
daddi $a0, $0, cad_msg
daddi $a1, $0, A
jal imprimir
daddi $a0, $0, minu_msg
daddi $a1, $0, B
jal imprimir
halt

procesar_cadena: daddi $sp, $sp, -8
                 sd $ra, 0($sp)
                 daddi $sp, $sp, -8
                 sd $a0, 0($sp)
                 dadd $t0, $0, $a0
                 dadd $t1, $0, $a1
                 loop: lbu $t2, 0($t0)
                       beqz $t2, fin
                       dadd $a0, $0, $t2
                       jal es_mayu
                       beqz $v0, siguiente
                       jal convertir_minu
                       sb $v0, 0($t0)
                       sb $v0, 0($t1)
                       daddi $t1, $t1, 1
                       siguiente: daddi $t0, $t0, 1
                                  j loop
                       fin: sb $0, 0($t1)
                            ld $a0, 0($sp)
                            daddi $sp, $sp, 8
                            ld $ra, 0($sp)
                            daddi $sp, $sp, 8
                            jr $ra

es_mayu: daddi $v0, $0, 0
         slti $t3, $a0, 0x41
         bnez $t3, finmayu
         slti $t3, $a0, 0x5B
         beqz $t3, finmayu
         daddi $v0, $v0, 1
         finmayu: jr $ra

convertir_minu: daddi $v0, $a0, 0x20
                jr $ra

imprimir: sd $a0, 0($s1)
          daddi $t0, $0, 4
          sd $t0, 0($s0)
          sd $a1, 0($s1)
          sd $t0, 0($s0)
          jr $ra
