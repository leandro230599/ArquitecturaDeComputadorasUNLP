;  12)  Interrupción por hardware: TIMER.

;       Implementar a través de un programa un reloj segundero que muestre en pantalla los segundos 
;       transcurridos (00-59 seg) desde el inicio de la ejecución.

TIMER EQU 10H
PIC EQU 20H
EOI EQU 20H
N_CLK EQU 10

ORG 40
IP_CLK DW RUT_CLK

ORG 1000H
SEG DB 30H
 DB 30H
FIN DB ?

 ORG 3000H
RUT_CLK: PUSH AX
 INC SEG+1
 CMP SEG+1, 3AH
JNZ RESET
 MOV SEG+1, 30H
 INC SEG
CMP SEG, 36H
 JNZ RESET
 MOV SEG, 30H
RESET: INT 7
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
 MOV AL, 1
 OUT TIMER+1, AL ; TIMER: registro COMP
 MOV AL, 0
OUT TIMER, AL ; TIMER: registro CONT
 MOV BX, OFFSET SEG
 MOV AL, OFFSET FIN-OFFSET SEG
STI
LAZO: JMP LAZO

 END

;  Explicar detalladamente:
;  A)  Cómo funciona el TIMER y cuándo emite una interrupción a la CPU.

  El TIMER  se va ejecutando con su reloj, el cual cuando hace tic, incrementa el registro CONT
  en uno y cuando este coincide con el registro COMP, se dispara una interrupcion INT1 del PIC

;  B)  La función que cumplen sus registros, la dirección de cada uno y cómo se programan

  El registro CONT es el que se incremenda cuando el reloj del TIMER emite un tic, y se encuentra
  en la direccion 10h y el COMP es el que compara con el CONT para emitir la interrupcion INT1 o no.
  Se encuentra en la direccion 11h
