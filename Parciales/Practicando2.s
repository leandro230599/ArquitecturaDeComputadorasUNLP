;   Escribir un programa en WinMIPS64 que lea 3 numeros enteros (A,B y C) ingresados por el usuario desde el teclado, resuelva el
;   calculo (A-B) y almacene el resultado en la memoria en la variable RES. El calculo debe resolverse en una subrutina que reciba
;   como parametros los 3 operandos y retorne el valor del resultado. Finalmente, el valor calculado debe mostrarse en la pantalla
;   alfanumerica. Debe utilizarse la convencion para nombrar los registros que se empleen durante el programa

.data
A: .word 0
B: .word 0
C: .word 0
RES: .word 0
CONTROL: .word32 0x10000
DATA: .word 0x10008

.code
lwu $s0, CONTROL($zero)
lwu $s1, DATA($zero)
daddi $s2, $zero, RES
daddi $t0, $zero, 8
sd $t0, 0($s0)
ld $a0, 0($s1)
sd $t0, 0($s0)
ld $a1, 0($s1)
sd $t0, 0($s0)
ld $a2, 0($s1)
jal calculo
sd $v0, 0($s2)
sd $v0, 0($s1)
daddi $t0, $zero, 2
sd $t0, 0($s0)
halt

calculo: daddi $v0, $zero, 0
         dsub $t0, $a0, $a1
         dadd $t1, $zero, $a2
         bnez $t1, continua
         slti $t3, $t1, 0
         beqz $t3, positivo
         daddi $v0, $v0, -1
         jr $ra
         positivo: daddi $v0, $v0, 1
                   jr $ra
         continua: dadd $t5, $zero, $t0
                   daddi $t1, $t1, -1
         loop: beqz $t1, fin_loop
               dmul $t5, $t5, $t0
               daddi $t1, $t1, -1
               j loop
         fin_loop: dadd $v0, $zero, $t5
                   jr $ra   