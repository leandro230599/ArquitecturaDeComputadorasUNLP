.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
A: .asciiz "C"

.code
lwu $s0, CONTROL($0)
lwu $s1, DATA($0)
lbu $a0, A($0)
jal es_mayu
halt

es_mayu: daddi $v0, $0, 0
         slti $t3, $a0, 0x41
         bnez $t3, fin_mayu
         slti $t3, $a0, 0x5B
         beqz $t3, fin_mayu
         daddi $v0, $v0, 1
         fin_mayu: jr $ra