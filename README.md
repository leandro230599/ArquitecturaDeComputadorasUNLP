# ArquitecturaDeComputadorasUNLP

## A tomar en cuenta

* Los registros siempre se apilan enteros de 16 bits (2 bytes), por lo tanto, si yo quiero agarrar un dato de 1 byte, moviendolo a registro, debo hacerlo usando la parte baja o alta de un registro, por ejemplo AL o AH, si uso el entero AX, tomara el byte y el siguiente, el primero como la parte baja y el siguiente como la parte alta

    Ejemplo
  
        ORG 1000h
        datos DB 10h, 11h
        ORG 2000h
        	mov BX, 1000h
        	mov AX, [BX]

    | Registro | Parte alta | Parte baja |
    |----------|----------|----------|
    | AX | AH = 11h | AL = 10h |
    | BX | BH = 10h | BL = 00h |


* PUSH, primero hace -1 y guarda, -1 y guarda
    
  POP, primero saca y +1, saca y +1

* En interrupciones, AL es para la cantidad de caracteres y BX el puntero a memoria

* Intel 8086 almacena los valores de forma Little Endian

* Las interrupciones se almacenan en int X = X * 4 en memoria, en el caso de INT 7, en 28h, por 7 * 4 bytes

* MOV se usa para CPU -> Memoria o Memoria -> CPU

* IN DX, AL se utiliza para Dispositivo -> CPU

* OUT AL, DX se utiliza para CPU -> Dispositivo

* El uso de DX y AL es obligatorio y es para ..... 

## Pendientes


## Consultas realizadas

* ¿En un pasaje de parametro por pila, es necesari siempre pushear antes los registros?
    > Si no se utilizo un registro, no hace falta pushearlo, pero si fue utilizado antes, por cualquiera que sea el motivo de uso, relevante o no, se debe pushear
* ¿Hay forma de poner una etiqueta en la primera linea de una subrutina por si quisiera que empiece con un loop?
    > Una subrutina es una etiqueta, por lo cual se puede hacer un salto asi misma
* Los valores de retorno de una subrutina (ya sea por referencia o registros), ¿se deben guardar en algun lado o no hace falta?
    > Si el enunciado no aclara que se guarde en tal lado, no hace falta hacerlo, si pide retornar por algun medio, con eso basta, no hace falta guardarlo en memoria
* En algunos enunciados, los datos se los declara apartir de la direccion 1000h, pero otros datos en la 1500h o alguna parecida, ¿porque?
    > Por simple comodidad,  no afecta en nada, podria estar tambien despues de los datos que esten apartir de la 1000h, es como para separar o si hay datos que no se conoce el tamaño puede que se use esto
