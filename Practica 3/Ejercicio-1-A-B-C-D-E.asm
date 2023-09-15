;  1)  Uso de las luces y las llaves a través del PIO. Ejecutar los programas con el simulador VonSim
;      utilizando los dispositivos “Llaves y Luces” que conectan las llaves al puerto PA del PIO y a 
;      las luces al puerto PB.

;  A)  Escribir un programa que encienda las luces con el patrón 11000011, o sea, solo las primeras
;      y las últimas dos luces deben prenderse, y el resto deben apagarse.

PIO EQU 30H

ORG 2000h
MOV AL, 0
OUT PIO+3, AL
MOV AL, 11000011B
OUT PIO+1, AL
INT 0
END

--------------------------------------------------------------------------------------------------------------

;  B)  Escribir un programa que verifique si la llave de más a la izquierda está prendida.
;      Si es así, mostrar en pantalla el mensaje “Llave prendida”, y de lo contrario mostrar
;      “Llave apagada”. Solo importa el valor de la llave de más a la izquierda 
;      (bit más significativo). Recordar que las llaves se manejan con las teclas 0-7.

PIO EQU 30H

ORG 1000h
ON DB "Llave prendida"
OFF DB "Llave apagada"
FIN DB ?

ORG 2000h
MOV AL, 0FFH
OUT PIO+2, AL
IN AL, PIO
AND AL, 10000000B
JZ ES_OFF
MOV BX, offset ON
MOV AL, offset OFF - offset ON
INT 7
JMP FIN_P
ES_OFF: MOV BX, offset OFF
        MOV AL, offset FIN - offset OFF
        INT 7
FIN_P: INT 0
END

--------------------------------------------------------------------------------------------------------------

;  C)  Escribir un programa que permite encender y apagar las luces mediante las llaves. 
;      El programa no deberá terminar nunca, y continuamente revisar el estado de las llaves,
;      y actualizar de forma consecuente el estado de las luces. La actualización se realiza 
;      simplemente prendiendo la luz i si la llave i correspondiente está encendida (valor 1), 
;      y apagándola en caso contrario. Por ejemplo, si solo la primera llave está encendida, 
;      entonces solo la primera luz se debe quedar encendida

PIO EQU 30H

ORG 2000h
MOV AL, 0FFH
OUT PIO+2, AL
MOV AL, 0
OUT PIO+3, AL
LAZO: IN AL, PIO
      OUT PIO+1, AL
      JMP LAZO
END

--------------------------------------------------------------------------------------------------------------

;  D)  Escribir un programa que implemente un encendido y apagado sincronizado de las luces. 
;      Un contador, que inicializa en cero, se incrementa en uno una vez por segundo. Por cada
;      incremento, se muestra a través de las luces, prendiendo solo aquellas luces donde el valor 
;      de las llaves es 1. Entonces, primero se enciende solo la luz de más a la derecha,
;      correspondiente al patrón 00000001. Luego se continúa con los patrones 00000010, 00000011,
;      y así sucesivamente. El programa termina al llegar al patrón 11111111.


TIMER EQU 10H
PIC EQU 20H
EOI EQU 20H
PIO EQU 30H
N_CLK EQU 10

ORG 40
IP_CLK DW RUT_CLK

ORG 3000H
RUT_CLK: PUSH AX
         MOV AL, DL
         OUT PIO+1, AL
         INC DL
         MOV AL, 0
         OUT TIMER, AL
         MOV AL, EOI
         OUT PIC, AL
         POP AX
         IRET

ORG 2000h
CLI
MOV AL, 0
OUT PIO+3, AL
MOV AL, 0FDH
OUT PIC+1, AL
MOV AL, N_CLK
OUT PIC+5, AL
MOV AL, 1
OUT TIMER+1, AL
MOV AL, 0
OUT TIMER, AL
STI
MOV DL, 0
LAZO: CMP DL, 0FFH
      JNZ LAZO
      INT 0
END

--------------------------------------------------------------------------------------------------------------

