;  11)  Escribir un programa que permita seleccionar una letra del abecedario al azar. El código 
;       de la letra debe generarse en un registro que incremente su valor desde el código de
;       A hasta el de Z continuamente. La letra debe quedar seleccionada al presionarse la tecla F10 
;       y debe mostrarse de inmediato en la pantalla de comandos. 

PIC EQU 20H
EOI EQU 20H
N_F10 EQU 10 ; Seria la direccion 40 en memoria por 10*4 bytes

ORG 40
IP_F10 DW RUT_F10 ; Guarda la direccion de la subrutina

ORG 1000h
caracter DB "A"

ORG 2000H
 CLI ; Deshabilita interrupciones
 MOV AL, 0FEH ; Guarda 11111110b para que este habilitado INT0
 OUT PIC+1, AL ; PIC: registro IMR
 MOV AL, N_F10 ; Guarda 10 en AL osea 0Ah
 OUT PIC+4, AL ; PIC: registro INT0, le pasa 0Ah, que seria decirle
               ; Anda a 10*4 = 40 o 28h direccion de memoria a buscar la subrutina
               ; Que se debe ejecutar al activar esta interrupcion
 MOV DH, 5Ah ; Guardo en DH el codigo ascii de Z
 MOV DL, 41h ; Guardo en DL el codigo ascii de A
 MOV BX, offset caracter ; Guardo en BX la direccion de caracter
 STI ; Permite las interrupciones
 LAZO: CMP DL, DH
       jnz SALTO
       MOV DL, 41h
       JMP LAZO
 SALTO:inc DL
       JMP LAZO ; Buble infinito
ORG 3000H
 RUT_F10: PUSH AX ; Guarda el valor de AX
          MOV AL, 1
          MOV [BX], DX
          INT 7
          MOV AL, EOI ; Guarda 20h en AL, diciendo que termino
          OUT EOI, AL ; PIC: registro EOI
          POP AX ; Vuelve a obtener el valor de AX antes de que se modificara
          IRET ; Retorna de rutina de interrupcion

 END
