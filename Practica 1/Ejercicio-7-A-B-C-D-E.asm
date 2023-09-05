; Multiplicación de números sin signo. Pasaje de parámetros a través de Pila.
; El programa de abajo utiliza una subrutina para multiplicar dos números, pasando los parámetros por valor para NUM1
; y NUM2, y por referencia (RES), en ambos casos a través de la pila. Analizar su contenido y contestar. 


ORG 3000H ; Subrutina MUL
  MUL: PUSH BX ; preservar registros
       PUSH CX
       PUSH AX
       PUSH DX
       MOV BX, SP
       ADD BX, 12 ; corrección por el IP(2),
       ; RES(2) y los 4 registros(8)
       MOV CX, [BX] ; cx = num2
       ADD BX, 2 ; bx apunta a num1
       MOV AX, [BX] ; ax = num1
       SUB BX, 4 ; bx apunta a la dir de
       ; resultado
       MOV BX, [BX] ; guardo
       MOV DX, 0
       SUMA: ADD DX, AX
       DEC CX
       JNZ SUMA
       MOV [BX], DX ; guardar resultado
       POP DX ;restaurar registros
       POP AX
       POP CX
       POP BX
       RET
       
ORG 1000H ; Memoria de datos
  NUM1 DW 5H
  NUM2 DW 3H
  RES DW ?
  
ORG 2000H; Prog principal
 ; parámetros
 MOV AX, NUM1
 PUSH AX
 MOV AX, NUM2
 PUSH AX
 MOV AX, OFFSET RES
 PUSH AX
 CALL MUL
 ; desapilar parámetros
 POP AX
 POP AX
 POP AX
 HLT
END


; A) ¿Cuál es el modo de direccionamiento de la instrucción MOV AX, [BX]? ¿Qué se copia en el registro AX en este
;caso?

; El modo de direccionamiento de la instruccion MOV AX, [BX] es indirecto via registro, y lo que se copia en
; el registro AX es el contenido de la direccion que tiene BX, BX tiene la direccion donde se almacena NUM1 en la pila,
; entonces al usar [BX] le esta pasando a AX, el contenido de esa direccion de memoria, AX quedaria con 5h
-----------------------------------------------------------------------------------------------------------------

; B) ¿Qué función cumple el registro temporal ri que aparece al ejecutarse una instrucción como la anterior?

; El registro RI almacena una direccion de memoria temporal, se usa en direccionamiento directo o indirecto
; cuando se tiene un etiqueta o una direccion de memoria, y se debe ver su contenido
-----------------------------------------------------------------------------------------------------------------

; C) ¿Qué se guarda en AX al ejecutarse MOV AX, OFFSET RES?

; Se guarda en AX, la direccion de memoria donde apunta la etiqueta RES, en este caso es 1004h
-----------------------------------------------------------------------------------------------------------------

; D) ¿Cómo se pasa la variable RES a la pila, por valor o por referencia? ¿Qué ventaja tiene esto? 

; Se pasa por referencia porque se manda su direccion en memoria, la ventaja que trae esto ademas de la eficiencia por acceder
; directamente sobre la memoria de una, es que se trabaja sobre el dato original y no una copia
-----------------------------------------------------------------------------------------------------------------

; E) ¿Cómo trabajan las instrucciones PUSH y POP? 

; PUSH: Carga la fuente en el tope de la pila, primero hace SP - 1, y almacena la parte alta, luego SP - 1, y almacena la parte baja
; Ejemplo: 
  SP = 8000h, AX = 1234h
  PUSH AX, SP - 1 => 8000h - 1 = 7FFFh | 7FFFh = 12h
           SP - 1 => 7FFFh - 1 = 7FFEh | 7FFEh = 34h
  SP queda en 7FFEh la cual contiene a 34h

; POP: Desapila el top de la pila y lo almacena en destino, primero saca el tope de la pila que es la parte baja y lo almacena en la parte baja
; del destino y hace SP + 1, y vuelve a sacar el tope de la pila que es la parte alta y lo almacena en la parte alta del estino y hace SP + 1
; Ejemplo:
  SP = 7FFEh AX= Basura
  POP AX, SP = 7FFEh = 34h => AL = 34h | SP + 1
          SP = 7FFFh = 12h => AH = 12h | SP + 1
  SP queda en 8000h
