;  13)  Modificar el programa anterior para que también cuente minutos (00:00 - 59:59), 
;       pero que actualice la visualización en pantalla cada 10 segundos. 


TIMER EQU 10H
PIC EQU 20H
EOI EQU 20H
N_CLK EQU 10

ORG 40
IP_CLK DW RUT_CLK

ORG 1000H
MIN DB 30H
    DB 30H
PUNTO DB 3Ah
SEG DB 30H
 DB 30H
FIN DB ?
LIMPIA DB 12

 ORG 3000H
RUT_CLK: PUSH AX
 ADD SEG+1, 10
 CMP SEG+1, 3AH
 JNZ RESET
 MOV SEG+1, 30H
 INC SEG
 CMP SEG, 36H
 JNZ RESET
 MOV SEG, 30H
 INC MIN+1
 CMP MIN+1, 3AH
 JNZ RESET
 MOV MIN+1, 30H
 INC MIN
 CMP MIN+1, 36H
 JNZ RESET
 MOV MIN, 30H
RESET: MOV BX, offset LIMPIA
       MOV AL, 1
       INT 7
       MOV BX, OFFSET MIN
       MOV AL, OFFSET FIN-OFFSET MIN
       INT 7
       MOV AL, 0
       OUT TIMER, AL
       MOV AL, EOI
       OUT PIC, AL
       POP AX
       IRET

 ORG 2000H
CLI
 MOV AL, 0FDH
 OUT PIC+1, AL ; PIC: registro IMR
 MOV AL, N_CLK
 OUT PIC+5, AL ; PIC: registro INT1
 MOV AL, 10
 OUT TIMER+1, AL ; TIMER: registro COMP
 MOV AL, 0
OUT TIMER, AL ; TIMER: registro CONT
STI
LAZO: JMP LAZO

 END
