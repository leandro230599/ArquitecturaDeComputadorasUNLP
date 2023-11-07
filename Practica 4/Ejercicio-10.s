10) Escribir un programa que cuente la cantidad de veces que un determinado caracter aparece en una cadena de texto. Observar
    cómo se almacenan en memoria los códigos ASCII de los caracteres (código de la letra “a” es 61H). Utilizar la instrucción lbu
    (load byte unsigned) para cargar códigos en registros. La inicialización de los datos es la siguiente:

      .data
cadena: .asciiz "adbdcdedfdgdhdid" ; cadena a analizar
car: .asciiz "d" ; caracter buscado
cant: .word 0 ; cantidad de veces que se repite el caracter car en cadena
---------------------------------------------------------------------------------
      .data
cadena: .asciiz "adbdcdedfdgdhdid" ; cadena a analizar
car: .asciiz "d" ; caracter buscado
cant: .word 0 ; cantidad de veces que se repite el caracter car en cadena
TOTAL: .word 16;

	  .code
daddi r1, r1, 0
lbu r2, car(r0)
lw r3, cant(r0)
lw r4, TOTAL(r0)
loop: beqz r4, fin
	  lbu r5, cadena(r1)
	  bne r5, r2, continua
	  daddi r3, r3, 1
	  continua: daddi r4, r4, -1
	  daddi r1, r1, 1
	  j loop
fin: sw r3, cant(r0)
halt
