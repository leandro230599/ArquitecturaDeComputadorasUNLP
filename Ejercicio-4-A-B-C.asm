;  4)  Lectura de datos desde el teclado.
;      Escribir un programa que solicite el ingreso de un número (de un dígito) por teclado e inmediatamente lo muestre en la
;      pantalla de comandos, haciendo uso de las interrupciones por software INT 6 e INT 7.

ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
FIN DB ?

 ORG 1500H
NUM DB ?

 ORG 2000H
 MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN-OFFSET MSJ
 INT 7
 MOV BX, OFFSET NUM
INT 6
 MOV AL, 1
 INT 7
 MOV CL, NUM
 INT 0
 END 

;  A)  Con referencia a la interrupción INT 7, ¿qué se almacena en los registros BX y AL?

En BX se almacela la direccion de memoria base del contenido que debe mostrar en pantalla y AL la cantidad de elementos
que debe mostrar apartir de esa direccion base, a medida que se ejecuta la interrupcion, va aumentando el valor de BX en
base a la direccion a la que va avanzando y AL va disminuyendo por la cantidad que ya se represento en pantalla

-----------------------------------------------------------------------------------------------------------------------------------

;  B)  Con referencia a la interrupción INT 6, ¿qué se almacena en BX? 

En BX, se almacena la direccion de memoria donde se almacenara el dato ingresado por teclado con la INT 6

-----------------------------------------------------------------------------------------------------------------------------------

;  C)  En el programa anterior, ¿qué hace la segunda interrupción INT 7? ¿qué queda almacenado en el registro CL??

La segunda INT 7, imprime en pantalla el dato guardado en NUM, el cual fue ingresado por medio del teclado con la INT 6.
Y en el registro CL queda almacenado el codigo ascii de ese valor ingresado por teclado con la INT 6
