;  5)  Modificar el programa anterior agregando una subrutina llamada ES_NUM que verifique si el caracter ingresado es
;      realmente un número. De no serlo, el programa debe mostrar el mensaje “CARACTER NO VALIDO”. La subrutina debe
;      recibir el código del caracter por referencia desde el programa principal y debe devolver vía registro el valor 0FFH en caso
;      de tratarse de un número o el valor 00H en caso contrario. Tener en cuenta que el código del “0” es 30H y el del “9” es 39H. 

ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
FIN DB ?

ORG 1200H
N_VALIDO DB "CARACTER NO VALIDO"
FIN_CHAR DB ?

ORG 1500H
NUM DB ?

ORG 3000h
ES_VALIDO: MOV CX, 0FFH
           RET
NO_VALIDO: MOV CX, 00H
           RET
ES_NUM:  CMP BYTE PTR [BX], 30H
         JS NO_VALIDO
         CMP BYTE PTR [BX], 3AH
         JNS NO_VALIDO
         JMP ES_VALIDO

ORG 2000H
  MOV BX, OFFSET MSJ
  MOV AL, OFFSET FIN-OFFSET MSJ
  INT 7
  MOV BX, OFFSET NUM
  INT 6
  CALL ES_NUM
  CMP CX, 00H
  JNZ FIN_P
  MOV BX, offset N_VALIDO
  MOV AL, offset FIN_CHAR - offset N_VALIDO
  INT 7
  FIN_P: MOV CL, NUM
       INT 0
END
