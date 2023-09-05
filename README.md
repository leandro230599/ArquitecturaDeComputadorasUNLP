# ArquitecturaDeComputadorasUNLP

## A tomar en cuenta

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