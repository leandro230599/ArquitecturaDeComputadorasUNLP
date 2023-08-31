; 8)  Subrutinas para realizar operaciones con cadenas de caracteres 

; A)  Escribir una subrutina LONGITUD que cuente el número de caracteres de una cadena de caracteres terminada en
;     cero (00H) almacenada en la memoria. La cadena se pasa a la subrutina por referencia vía registro, y el resultado se
;     retorna por valor también a través de un registro.

ORG 3000H ; Subrutina MUL
  LONGITUD: PUSH BX
            MOV AL, 0
            LOOP: MOV AH, [BX]
                  CMP AH, 0
                  JZ FIN
                  INC AL
                  INC BX
                  JMP LOOP
            FIN: POP BX
                 RET
       
ORG 1000H ; Memoria de datos
  CADENA DB  'a','b','c','d',00h
  
ORG 2000H; Prog principal
 ; parámetros
 MOV BX, offset CADENA
 CALL LONGITUD 
 ; En la parte baja de AX guardo la cantidad de caracteres
 ; En la parte alta esta el ascii leido
 HLT
END

---------------------------------------------------------------------------------------------------------------------------------

; B)  Escribir una subrutina CONTAR_MIN que cuente el número de letras minúsculas de la ‘a’ a la ‘z’ de una cadena de
;     caracteres terminada en cero almacenada en la memoria. La cadena se pasa a la subrutina por referencia vía registro,
;     y el resultado se retorna por valor también a través de un registro.
;     Ejemplo: CONTAR_MIN de ‘aBcDE1#!’ debe retornar 2. 

ORG 3000H ; Subrutina MUL
  CONTAR_MIN: PUSH BX
            MOV AL, 0
            LOOP: MOV AH, [BX]
                  CMP AH, 0
                  JZ FIN
                  CMP AH, 61h ; 61h es el ASCII de "a"
                  JS SALTO
                  CMP AH, 7Ah ; 7Ah es el ASCII de "z", pero uso 7Bh porque sino no cuenta "z"
                  JNS SALTO
                  INC AL
            SALTO: INC BX     
                  JMP LOOP
            FIN: POP BX
                 RET
       
ORG 1000H ; Memoria de datos
  CADENA DB  'a','B','c','D','E','1','z','#','!',00h
  
ORG 2000H; Prog principal
 ; parámetros
 MOV BX, offset CADENA
 CALL CONTAR_MIN 
 ; En la parte baja de AX guardo la cantidad de caracteres
 ; En la parte alta esta el ascii leido
 ; La parte de 7Bh, es porque no cuenta la Z dado a que si AH es "z" y comparo con su ASCII 
 ; el resultado dara 0 y no se activara el flag de negativo, por lo cual lo tomaria como un caracter
 ; despues de la Z, y no es asi, entonces con 7Bh, haria CMP 7Ah, 7Bh y si daria negativo, entonces
 ; funcionaria
 HLT
END

---------------------------------------------------------------------------------------------------------------------------------

; C) Escriba la subrutina ES_VOCAL, que determina si un carácter es vocal o no, ya sea mayúscula o minúscula.
;    La rutina debe recibir el carácter por valor vía registro, y debe retornar, también vía registro, 
;    el valor 0FFH si el carácter es una vocal, o 00H en caso contrario.
;    Ejemplos: ES_VOCAL de ‘a’ o ‘A’ debe retornar 0FFh y ES_VOCAL de ‘b’ o de ‘4’ debe retornar 00h 


ORG 3000H ; Subrutina MUL
  EXISTE: MOV CX, 0FFh
          JMP FIN
  NO_EXISTE: MOV CX, 00h
             JMP FIN
  ES_VOCAL: PUSH BX
            MOV AH, 0
            LOOP: MOV AH, [BX]
                  CMP AH, 0h
                  JZ NO_EXISTE
                  CMP AH, AL
                  JZ EXISTE
                  INC BX   
                  JMP LOOP
            FIN: POP BX
                 RET
       
ORG 1000H ; Memoria de datos
  vocales DB  "aeiouAEIOU"
          DB 00h
  caracter DB "U"
  
ORG 2000H; Prog principal
 ; parámetros
 MOV AL, caracter
 MOV BX, offset vocales
 CALL ES_VOCAL 
 ; El registro CX retornara si es vocal o no
 HLT
END

-------------------------------------------------------------------------------------------------------------------------------

; D)  Usando la subrutina anterior escribir la subrutina CONTAR_VOC, que recibe una cadena terminada 
;     en cero por referencia a través de un registro, y devuelve, en un registro, la cantidad de 
;     vocales que tiene esa cadena.
;     Ejemplo: CONTAR_VOC de ‘contar1#!’ debe retornar 2

ORG 3000H ; Subrutina MUL
  EXISTE: MOV CL, 0FFh
          JMP FIN
  NO_EXISTE: MOV CL, 00h
             JMP FIN
  ES_VOCAL: PUSH BX
            LOOP: MOV AH, [BX]
                  CMP AH, 0h
                  JZ NO_EXISTE
                  CMP AH, AL
                  JZ EXISTE
                  INC BX   
                  JMP LOOP
            FIN: POP BX
                 RET
  CONTAR_VOC:  MOV CH, 0 
               LOOP_CONTAR: PUSH BX
               MOV BX, DX
               MOV AL, [BX]
               POP BX
               CMP AL, 0h
               JZ FIN_CONTAR
               CALL ES_VOCAL
               CMP CL, 0FFh
               JNZ SALTO
               INC CH
               SALTO: INC DX
               JMP LOOP_CONTAR
               FIN_CONTAR: RET                                               
       
ORG 1000H ; Memoria de datos
  vocales DB  "aeiouAEIOU"
          DB 00h
  cadena DB "contar1#!",00h
  
ORG 2000H; Prog principal
 ; parámetros
 MOV DX, offset cadena
 MOV BX, offset vocales
 CALL CONTAR_VOC 
 ; CL Tendra si es vocal o no
 ; CH Tendra el contador de vocales
 ; AL Tendra el caracter de cadena
 ; AH Tendra la vocal de vocales
 ; DX tendra la direccion de la cadena
 ; BX tendra la direccion de las vocales
 ; El push es para guardar el contenido de BX y poder acceder a la direccion en DX
 HLT
END

-------------------------------------------------------------------------------------------------------------------------------------------------

; E)  Escriba la subrutina CONTAR_CAR que cuenta la cantidad de veces que aparece un
;     carácter dado en una cadena terminada en cero. El carácter a buscar se debe pasar
;     por valor mientras que la cadena a analizar por referencia, ambos a través de la pila.
;     Ejemplo: CONTAR_CAR de ‘abbcde!’ y ‘b’ debe retornar 2, mientras que CONTAR_CAR de ‘abbcde!’ y ‘z’
;     debe retornar 0. 

ORG 3000H ; Subrutina MUL
CONTAR_CAR: 
            mov cl, 0
            mov bx, sp
            add bx, 2
            mov al, [bx]
            add bx, 2
            mov bx, [BX]
            loop: mov ah, [BX]
            cmp ah, 0
            jz fin
            cmp ah, al
            jnz no_es
            inc cl
            no_es: inc bx
            jmp loop
            fin: ret
      
ORG 1000H ; Memoria de datos
  cadena DB  "abbcde!"
          DB 00h
  caracter DB "z"
  
ORG 2000H; Prog principal
 ; parámetros
 mov ax, offset cadena
 push ax
 mov al, caracter
 push ax
 CALL CONTAR_CAR 
 pop ax
 pop ax
 HLT
END

---------------------------------------------------------------------------------------------------------------------------------------------------

; F)  Escriba la subrutina REEMPLAZAR_CAR que reciba dos caracteres (ORIGINAL y REEMPLAZO) por valor a
;     través de la pila, y una cadena terminada en cero también a través de la pila. 
;     La subrutina debe reemplazar el carácter ORIGINAL por el carácter REEMPLAZO.

ORG 3000H ; Subrutina MUL
REEMPLAZAR_CAR: 
            mov bx, sp
            add bx, 2
            mov al, [bx]
            add bx, 2
            mov ah, [bx]
            add bx, 2
            mov bx, [BX]
            loop: mov cl, [BX]
            cmp cl, 0
            jz fin
            cmp cl, ah
            jnz no_es
            mov byte ptr [bx], al
            no_es: inc bx
            jmp loop
            fin: ret
      
ORG 1000H ; Memoria de datos
  cadena DB  "chicas"
          DB 00h
  original DB "a"
  reemplazo db "x"
  
ORG 2000H; Prog principal
 ; parámetros
 mov ax, offset cadena
 push ax
 mov al, original
 push ax
 mov al, reemplazo
 push ax
 CALL REEMPLAZAR_CAR 
 ; En AL guardo el caracter reeemplazo
 ; En AH guardo el caracter original
 pop ax
 pop ax
 HLT
END
