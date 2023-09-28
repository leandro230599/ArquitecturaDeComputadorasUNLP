;  3)  Uso de la impresora a través del HAND-SHAKE. Ejecutar los programas configurando 
;      el simulador VonSim con los dispositivos “Impresora (Handshake)”

;      A)  Escribir un programa que imprime “INGENIERIA E INFORMATICA” en la impresora
;          a través del HAND-SHAKE. La comunicación se establece por consulta de estado
;          (polling). ¿Qué diferencias encuentra con el ejercicio 2b?



HAND EQU 40H

ORG 1000H
MSJ DB "INGENIERIA E INFORMATICA"
FIN DB ?

ORG 2000H
MOV BX, OFFSET MSJ                ;    |  LE PASO LA DIRECCION BASE DEL MENSAJE AL REGISTRO BX
MOV CL, OFFSET FIN - OFFSET MSJ   ;    |  LE PASO A CL LA CANTIDAD DE CARACTERES A IMPRIMIR

LOOP: IN AL, HAND+1               ;    |  CONSULTO EL ESTADO, OBTENGO EL ESTADO DEL HAND
      AND AL, 01H                 ;    |  VERIFICO SI EL BUSY ESTA LIBRE O NO
      JNZ LOOP                    ;    |  SI NO LO ESTA, SIGO EN EL POOLING ESPERANDO

MOV AL, [BX]                      ;    |  BUSY LIBRE, LE PASO EL DATO AL REGISTRO "AL"
OUT HAND, AL                      ;    |  Y ESTE A HAND QUE SERIA DATA POR DIRECCION 40H, 41H ES ESTADO
INC BX                            ;    |  INCREMENTO BX PARA QUE PASE AL SIGUIENTE CARACTER
DEC CL                            ;    |  DECREMENTO "CL" PORQUE TIENE QUE IMPRIMIR UN CARACTER MENOS
JNZ LOOP                          ;    |  SI NO TERMINO DE IMPRIMIR, CONSULTA EL BUSY E IMPRIME
INT 0
END

Diferencias que se notan son que el programa es mas corto, se debe configurar menos cosas 
ya que no debo estar tocando el CA/CB, ademas me ahorro el tener que estar mandando el pulso
en el Strobe, primero con 1 para que imprima y luego reiniciandolo a 0, me ahorro pasos

---------------------------------------------------------------------------------------------

;      B)  ¿Cuál es la ventaja en utilizar el HAND-SHAKE con respecto al PIO para comunicarse 
;          con la impresora? Sacando eso de lado, ¿Qué ventajas tiene el PIO, en general, con 
;          respecto al HAND-SHAKE?

La ventaja de utilizar el HAND-SHAKE es que es mas sencillo ya que viene configurado por
defecto el estado que trae el Strobe y el Busy, en PIO se los debe configurar manualmente si
son de salida o entrada, y se debe configurar el data para que sea de salida, en cambio en
HAND-SHAKE no hace falta eso, ademas de que se debe estar enviando el pulso en Strobe para
que imprima y despues resetearlo a 0 en PIO, cosa que con HAND-SHAKE tampoco hace falta, se
hace solo.

La ventaja que tiene el PIO es que sirve para Dispositivo de Entrada/Salida en general, no
es solo para impresora como el HAND-SHAKE, sirve para cualquier dispositivo, impresora, led,
etc. Al ser para cualquier dispositivo de Entrada/Salida es una gran ventaja poder modificar
todo como me resulte mejor, HAND-SHAKE es para impresora y esta preconfigurado y no puedo
modificar eso.

---------------------------------------------------------------------------------------------

;      C)  Escribir un programa que imprime “UNIVERSIDAD NACIONAL DE LA PLATA” en la 
;          impresora a través del HAND-SHAKE. La comunicación se establece por 
;          interrupciones emitidas desde el HAND-SHAKE cada vez que la impresora se desocupa.



PIC EQU 20H
EOI EQU 20H
HAND EQU 40H
N_HND EQU 10

ORG 40
IP_HND DW RUT_HND

ORG 1000H
MSJ DB "UNIVERSIDAD NACIONAL DE LA PLATA"
FIN DB ?

ORG 3000H
RUT_HND: PUSH AX
         MOV AL, [BX]
         OUT HAND, AL
         INC BX
         DEC CL
         MOV AL, EOI
         OUT PIC, AL
         POP AX
         IRET

ORG 2000H
MOV BX, OFFSET MSJ                ;    |  LE PASO LA DIRECCION BASE DEL MENSAJE AL REGISTRO BX
MOV CL, OFFSET FIN - OFFSET MSJ   ;    |  LE PASO A CL LA CANTIDAD DE CARACTERES A IMPRIMIR
CLI
MOV AL, 0FBh
OUT PIC+1, AL
MOV AL, N_HND
OUT PIC+6, AL
MOV AL, 80H
OUT HAND+1, AL
STI
LOOP: CMP CL, 0
      JNZ LOOP  
IN AL, HAND+1
AND AL, 7FH
OUT HAND+1, AL
INT 0
END

---------------------------------------------------------------------------------------------

;      D)  Escribir un programa que solicite el ingreso de cinco caracteres por teclado
;          y los almacene en memoria. Una vez ingresados, que los envíe a la impresora 
;          a través del HAND-SHAKE, en primer lugar tal cual fueron ingresados y a
;          continuación en sentido inverso. Utilizar el HAND-SHAKE  en modo consulta
;          de estado. ¿Qué diferencias encuentra con el ejercicio 2c?

HAND EQU 40H

ORG 1000H
CHARS DB ?

org 2000h
  MOV CL, 5
  MOV BX, OFFSET CHARS
  LOOP_CHARS: INT 6
              INC BX
              DEC CL
              JNZ LOOP_CHARS

  MOV CL, 5
  MOV CH, 5
  MOV BX, OFFSET CHARS
  
  POOL: IN AL, HAND+1
        AND AL, 01H
        JNZ POOL
        
  CMP CL, 0
  JZ IMPR_REVER
  
  IMPR_BIEN: MOV AL, [BX]
             OUT HAND, AL
             PUSH BX
             INC BX
             DEC CL
             JNZ POOL

  IMPR_REVER: POP BX
              MOV AL, [BX]
              OUT HAND, AL
              DEC CH
              JNZ POOL

  INT 0  
end


---------------------------------------------------------------------------------------------


