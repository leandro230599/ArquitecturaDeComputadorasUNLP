;  14)  Implementar un reloj similar al utilizado en los partidos de básquet, que arranque
;       y detenga su marcha al presionar sucesivas veces la tecla F10 y que finalice el conteo
;       al alcanzar los 30 segundos. 

TIMER EQU 10H
PIC EQU 20H
EOI EQU 20H
N_CLK EQU 10
N_F10 EQU 20

ORG 40
IP_CLK DW RUT_CLK

ORG 80
IP_F10 DW RUT_F10

ORG 1000H
SEG DB 30H
    DB 30H
FIN DB ?
LIMPIA DB 12

 ORG 3000H
 RUT_CLK: PUSH AX
 INC SEG+1
 CMP SEG+1, 3AH
 JNZ RESET
 MOV SEG+1, 30H
 INC SEG
 CMP SEG, 33H
 JNZ RESET
 MOV DL, 1
 MOV AL, 0FFh
 OUT PIC+1, AL
 RESET: MOV BX, offset LIMPIA
        MOV AL, 1
        INT 7
        MOV BX, OFFSET SEG
        MOV AL, 2
        INT 7
        MOV AL, 0
        OUT TIMER, AL
        MOV AL, EOI
        OUT PIC, AL
        POP AX
        IRET

 ORG 3500H
 RUT_F10: PUSH AX
          IN AL, PIC+1
          XOR AL, 00000010B
          OUT PIC+1, AL
          MOV AL, EOI
          OUT PIC, AL
          POP AX
          IRET
 
 ORG 2000H
 CLI
 MOV AL, 0FEH
 OUT PIC+1, AL ; PIC: registro IMR
 MOV AL, N_F10
 OUT PIC+4, AL ; PIC: registro INT0
 MOV AL, N_CLK
 OUT PIC+5, AL
 MOV AL, 1 ; Si estuviera antes el MOV AL, 0 - OUT TIMER, AL, fallaria
 OUT TIMER+1, AL
 MOV AL, 0
 OUT TIMER, AL
 MOV DL, 0
 STI
 LAZO: CMP DL, 0
       JZ LAZO
       INT 0
 END
