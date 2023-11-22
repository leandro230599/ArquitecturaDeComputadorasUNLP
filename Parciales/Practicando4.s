.data
X: .byte 45
Y: .byte 45
color: .byte 0,255,0,0
CONTROL: .word32 0x10000
DATA: .word32 0x10008
.code
lwu $s0, CONTROL($0)
lwu $s1, DATA($0)
lwu $t0, color($0)
sw $t0, 0($s1)
lbu $t1, Y($0) ; AGREGUE ESTO
lbu $t2, X($0)

daddi $t4, $0, 50
daddi $t5, $0, 50
loop: sb $t1,4($s1)
      sb $t2,5($s1)
      daddi $t3, $0,5  ; AGREGUE ESTO
      sd $t3,0($s0)
      daddi $t2, $t2, 1
      bne $t4, $t2, loop
      lbu $t2, X($0)
      daddi $t1, $t1, 1
      bne $t5, $t1, loop  ; AGREGUE ESTO
      halt