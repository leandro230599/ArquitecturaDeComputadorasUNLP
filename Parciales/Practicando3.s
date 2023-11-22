.data
tabla: .word 10,18,22,45,63
.code
daddi $t1, $zero, 5
daddi $t2, $zero, 0
daddi $t3, $zero, 0

loop: sd $t2, tabla($t3)
      daddi $t1, $t1, -1
      daddi $t2, $t2, 5
      bnez $t1, loop
      daddi $t3, $t3, 8
      halt