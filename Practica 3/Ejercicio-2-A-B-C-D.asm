;  2)  Uso de la impresora a través de la PIO. Ejecutar los programas configurando el simulador 
;      VonSim con los dispositivos “Impresora (PIO)”. En esta configuración, el puerto de datos
;      de la impresora se conecta al  puerto PB del PIO, y los bits de busy y strobe de la misma 
;      se conectan a los bits 0 y 1 respectivamente del puerto PA. Presionar F5 para mostrar la 
;      salida en papel. El papel se puede blanquear ingresando el comando BI.

;      A)  Escribir un programa para imprimir la letra “A” utilizando la impresora a través de la PIO.

PIO EQU 30h

ORG 2000h

MOV AL, 0FDh          ;    |
OUT PIO+2, AL         ;    |  CONFIGURO  EL CA DE BUSY, STROBE Y EL CB DE DATA
MOV AL, 0             ;    |  CONFIGURACION FIJA EN CUALQUIER CASO ES IGUAL
OUT PIO+3, AL         ;    |
IN AL, PIO            ;    |  INICIALIZACION
AND AL, 0FDh          ;    |  DEL STROBE
OUT PIO, AL           ;    |  EN 0

POOLING: IN AL, PIO   ;    |  CONSULTA DE ESTADO, OBTENGO ESTADO DEL PIO
         AND AL, 1    ;    |  Y VERIFICO SI EL BUSY ESTA LIBRE O NO
         JNZ POOLING  ;    |  SINO LO ESTA, SIGO EN EL POOLING ESPERANDO

MOV AL, 41H           ;    |  BUSY LIBRE, LE PASO EL DATO AL REGISTRO "AL"
OUT PIO+1, AL         ;    |  Y ESTE A PIO+1 OSEA PB QUE ES DATA

IN AL, PIO            ;    |  AHORA QUE EL DATO ESTA EN DATA OSEA PB 
OR AL, 02H            ;    |  DEBO DECIRLE A LA IMPRESORA QUE LO IMPRIMA
OUT PIO, AL           ;    |  POR ESO LE MANDO AL BIT DEL STROBE EL 1,

IN AL, PIO            ;    |  YA SE IMPRIMIO, AHORA DEBO SETEAR EL
AND AL, 0FDH          ;    |  BIT DEL STROBE EN 0 POR ESO EL "AND AL, 0FDh"
OUT PIO, AL           ;    |  QUE SERIA UNA MASCARA PARA SETEAR EN 0 ESE BIT

INT 0

END

--------------------------------------------------------------------------------------------------------------

;      B)  Escribir un programa para imprimir el mensaje “ORGANIZACION Y ARQUITECTURA DE
;          COMPUTADORAS” utilizando la impresora a través de la PIO.


PIO EQU 30h

ORG 1000h
MSJ DB "ORGANIZACION Y ARQUITECTURA DE COMPUTADORAS"
FIN DB ?

ORG 2000h

MOV AL, 0FDh          ;    |
OUT PIO+2, AL         ;    |  CONFIGURO  EL CA DE BUSY, STROBE Y EL CB DE DATA
MOV AL, 0             ;    |  CONFIGURACION FIJA EN CUALQUIER CASO ES IGUAL
OUT PIO+3, AL         ;    |
IN AL, PIO            ;    |  INICIALIZACION
AND AL, 0FDh          ;    |  DEL STROBE
OUT PIO, AL           ;    |  EN 0

MOV BX, OFFSET MSJ    ;    |  LE PASO LA DIRECCION BASE DEL MENSAJE AL REGISTRO BX

POOLING: IN AL, PIO   ;    |  CONSULTA DE ESTADO, OBTENGO ESTADO DEL PIO
         AND AL, 1    ;    |  Y VERIFICO SI EL BUSY ESTA LIBRE O NO
         JNZ POOLING  ;    |  SINO LO ESTA, SIGO EN EL POOLING ESPERANDO

MOV AL, [BX]          ;    |  BUSY LIBRE, LE PASO EL DATO AL REGISTRO "AL"
OUT PIO+1, AL         ;    |  Y ESTE A PIO+1 OSEA PB QUE ES DATA

IN AL, PIO            ;    |  AHORA QUE EL DATO ESTA EN DATA OSEA PB 
OR AL, 02H            ;    |  DEBO DECIRLE A LA IMPRESORA QUE LO IMPRIMA
OUT PIO, AL           ;    |  POR ESO LE MANDO AL BIT DEL STROBE EL 1,

IN AL, PIO            ;    |  YA SE IMPRIMIO, AHORA DEBO SETEAR EL
AND AL, 0FDH          ;    |  BIT DEL STROBE EN 0 POR ESO EL "AND AL, 0FDh"
OUT PIO, AL           ;    |  QUE SERIA UNA MASCARA PARA SETEAR EN 0 ESE BIT

INC BX                ;    |  YA IMPRIMIO EL CARACTER, DEBO VERIFICAR QUE NO TERMINO
CMP BX, OFFSET FIN    ;    |  DE IMPRIMIR TODOS LOS CARACTERES, OSEA QUE NO LLEGO A FIN
JNZ POOLING           ;    |  MIENTRAS NO LLEGO, VUELVE A CONSULTAR EL BUSY E IMPRIME

INT 0

END

--------------------------------------------------------------------------------------------------------------

;      C)  Escribir un programa que solicita el ingreso de cinco caracteres por teclado y los 
;          envía de a uno por vez a la impresora a través de la PIO a medida que se van 
;          ingresando. No es necesario mostrar los caracteres en la pantalla.



PIO EQU 30h

ORG 1000h
CHAR DB ?

ORG 2000h

MOV AL, 0FDh          ;    |
OUT PIO+2, AL         ;    |  CONFIGURO  EL CA DE BUSY, STROBE Y EL CB DE DATA
MOV AL, 0             ;    |  CONFIGURACION FIJA EN CUALQUIER CASO ES IGUAL
OUT PIO+3, AL         ;    |
IN AL, PIO            ;    |  INICIALIZACION
AND AL, 0FDh          ;    |  DEL STROBE
OUT PIO, AL           ;    |  EN 0

MOV DL, 5             ;    |  INICIO EL CONTADOR QUE TIENE CUANTAS VECES SE INGRESA UN CARACTER
MOV BX, OFFSET CHAR   ;    |  LE PASO LA DIRECCION DE CHAR PARA QUE BX TENGA LA DIRECCION DEL CARACTER


POOLING: IN AL, PIO   ;    |  CONSULTA DE ESTADO, OBTENGO ESTADO DEL PIO
         AND AL, 1    ;    |  Y VERIFICO SI EL BUSY ESTA LIBRE O NO
         JNZ POOLING  ;    |  SINO LO ESTA, SIGO EN EL POOLING ESPERANDO

INT 6                 ;    |  INGRESO CARACTER

MOV AL, [BX]          ;    |  BUSY LIBRE, LE PASO EL DATO DE CHAR AL REGISTRO "AL"
OUT PIO+1, AL         ;    |  Y ESTE A PIO+1 OSEA PB QUE ES DATA

IN AL, PIO            ;    |  AHORA QUE EL DATO ESTA EN DATA OSEA PB 
OR AL, 02H            ;    |  DEBO DECIRLE A LA IMPRESORA QUE LO IMPRIMA
OUT PIO, AL           ;    |  POR ESO LE MANDO AL BIT DEL STROBE EL 1,

IN AL, PIO            ;    |  YA SE IMPRIMIO, AHORA DEBO SETEAR EL
AND AL, 0FDH          ;    |  BIT DEL STROBE EN 0 POR ESO EL "AND AL, 0FDh"
OUT PIO, AL           ;    |  QUE SERIA UNA MASCARA PARA SETEAR EN 0 ESE BIT

DEC DL                ;    |  DECREMENTO DL
CMP DL, 0             ;    |  VERIFICO SI YA SE INGRESARON LOS 5 CARACTERES
JNZ POOLING           ;    |  SI NO SE INGRESARON TODOS, VUELVE A CONSULTAR BUSY E INGRESA CARACTER

INT 0

END
--------------------------------------------------------------------------------------------------------------
