;  10)  Interrupción por hardware: tecla F10.

;       Escribir un programa que, mientras ejecuta un lazo infinito, cuente el número de veces 
;       que se presiona la tecla F10 y acumule este valor en el registro DX.

PIC EQU 20H
EOI EQU 20H
N_F10 EQU 10 ; Seria la direccion 40 por 10*4

ORG 40
IP_F10 DW RUT_F10 ; Guarda la direccion de la subrutina

 ORG 2000H
 CLI ; Deshabilita interrupciones
 MOV AL, 0FEH ; Guarda 11111110b para que este habilitado INT0
 OUT PIC+1, AL ; PIC: registro IMR
 MOV AL, N_F10 ; Guarda 10 en AL osea 0Ah
 OUT PIC+4, AL ; PIC: registro INT0, le pasa 0Ah, que seria decirle
; Anda a 10*4 = 40 o 28h direccion de memoria a buscar la subrutina
; Que se debe ejecutar al activar esta interrupcion
MOV DX, 0 ; Inicia contador
 STI ; Permite las interrupciones
LAZO: JMP LAZO ; Buble infinito
 ORG 3000H
RUT_F10: PUSH AX ; Guarda el valor de AX
INC DX ; Incrementa contador
 MOV AL, EOI ; Guarda 20h en AL, diciendo que termino
 OUT EOI, AL ; PIC: registro EOI
 POP AX ; Vuelve a obtener el valor de AX antes de que se modificara
 IRET ; Retorna de rutina de interrupcion

 END
 
;  Explicar detalladamente:

;  A)  La función de los registros del PIC: ISR, IRR, IMR, INT0-INT7, EOI. Indicar la dirección de 
;      cada uno.

  EOI: End Of Interrupt (Direccion 20h de la memoria E/S) se utiliza para notificar que termino
  de ejecutarse la interrupcion, a este registro se le manda el byte de fin de interrupcion
  EOI que es coincidentemente 20h
  
  IMR: Interrupt Mask Register (Direccion 21h de la memoria E/S)se utiliza para enmascarar o 
  (inhabilitar) lineas de interrupcion. Si el bit correspondiente a una linea es 1, esta linea
  estara enmascarada y no se emitira la interrupcion a la CPU. Si el bit es 0 se emitira la 
  interrupcion a la CPU, el bit menos significativo corresponde a INT0 y el mas significativo
  corresponde a INT7. Puede ser modificado por la CPU

  IRR: Interrupt Request Register (Direccion 22h de la memoria E/S) indica las interrupciones
  pendientes. Si el bit correspondiente a una linea es 1, esta tiene un pedido de interrupcion
  pendiente, si tiene 0 es porque no hay interrupcion pendiente. Es modificado por el PIC y 
  es solo lectura para la CPU

  ISR: In-Service Register (Direccion 23h de la memoria E/S) indica que interrupcion esta
  siendo atendida en un momento dado. Si el bit correspondiente es 1, esta siendo atendida, si es 0
  no esta siendo atendida. Este es modificado por el PIC y solo lectura para la CPU

  INT0: Interrupcion por hardware 0, (Direccion 24h de la memoria E/S) esta conectado
  para el modulo tecla F10

  INT1: Interrupcion por hardware 1, (Direccion 25h de la memoria E/S) esta conectado
  para el modulo Timer

  INT2: Interrupcion por hardware 2, (Direccion 26h de la memoria E/S) esta conectado
  para el modulo HandShake

  INT3 al INT7: Utilizan las direcciones de memoria 27h, 28h, 29h, 2Ah, 2Bh respectivamente desde
  In3 27h a INT7 2Bh, no tienen uso
  

;  B)  Cuáles de estos registros son programables y cómo trabaja la instrucción OUT.

  Programables pueden ser aquellos que puede darsele una funcion como el INT0, INT1, INT2.
  La instruccion OUT guarda desde el CPU, algo en un dispositivo

;  C)  Qué hacen y para qué se usan las instrucciones CLI y STI. 

  CLI: Deshabilita las interrupciones por hardware
  STI: Habilita las interrupciones por hardware
