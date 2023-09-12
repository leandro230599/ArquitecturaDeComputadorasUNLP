;  15)  Escribir un programa que implemente un conteo regresivo a partir de un valor ingresado 
;       desde el teclado. El conteo debe comenzar al presionarse la tecla F10. El tiempo 
;       transcurrido debe mostrarse en pantalla, actualizándose el valor cada segundo

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
MENSAJE DB "IG:"
LIMPIA DB 12
VALOR DB ?

 ORG 3000H
 RUT_CLK: PUSH BX
 PUSH AX
 CMP VALOR, 30H
 JNZ RESET
 MOV DL, 1
 MOV AL, 0FFh
 OUT PIC+1, AL
 RESET: MOV BX, offset LIMPIA
        MOV AL, 1
        INT 7
        MOV BX, OFFSET VALOR
        MOV AL, 1
        INT 7
        MOV AL, 0
        OUT TIMER, AL
        MOV AL, EOI
        OUT PIC, AL
        DEC VALOR
        POP AX
        POP BX
        IRET

 ORG 3500H
 RUT_F10: PUSH BX
          PUSH AX
          IN AL, PIC+1
          XOR AL, 00000010B
          OUT PIC+1, AL
          MOV AL, EOI
          OUT PIC, AL
          POP AX
          POP BX
          IRET
 
 ORG 2000H
 CLI
 MOV AL, 0FEH
 OUT PIC+1, AL ; PIC: registro IMR para que atienda solo F10
 MOV AL, N_F10
 OUT PIC+4, AL ; PIC: registro INT0
 MOV AL, N_CLK
 OUT PIC+5, AL
 MOV AL, 1
 OUT TIMER+1, AL
 MOV AL, 0
 OUT TIMER, AL
 STI
 MOV BX, offset MENSAJE
 MOV AL, offset LIMPIA - offset MENSAJE
 INT 7
 MOV BX, offset VALOR
 INT 6
 MOV DL, 0
 LAZO: CMP DL, 0
       JZ LAZO
       INT 0
 END
