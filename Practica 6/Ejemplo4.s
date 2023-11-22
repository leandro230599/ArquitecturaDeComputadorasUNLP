;  Leer un caracter, verificar si es una "A"
;   CONTROL = 1 Imprime entero sin signo (poner numero en DATA) SALIDA ALFANUMERICA
;             2 Imprime entero con signo (poner numero en DATA) SALIDA ALFANUMERICA
;             3 Imprime un punto flotante (poner numero en DATA) SALIDA ALFANUMERICA
;             4 Imprime un string (asciiz) (poner direccion string en DATA) SALIDA ALFANUMERICA
;             5 Cambia el color de un pixel de la pantalla grafica (DATA a DATA+3 RGBA, DATA+4 Coordenada Y, DATA+5 Coordenada X) SALIDA GRAFICA
;             6 Limpia la pantalla alfanumerica (DATA no recibe nada) SALIDA ALFANUMERICA
;             7 Limpia la pantalla grafica (DATA no recibe nada)  SALIDA GRAFICA
;             8 Lee un numero (con coma se guarda como entero, sin coma como flotante) (Buscar el numero en DATA) ENTRADA TECLADO
;             9 Lee un caracter (Uno solo, y no hace falta pulsar enter) (Buscar el caracter en DATA, leer con LBU) ENTRADA TECLADO

.data
DIR_CONTROL: .word 0x10000
DIR_DATA: .word 0x10008
cod_a: .ascii "A"
msj_igual: .asciiz "Ingresaste una A"
msj_dist: .asciiz "NO ingresaste una A"

.code
ld $t6, DIR_CONTROL($0)     ; Cargo en $t6 CONTROL
ld $t7, DIR_DATA($0)        ; Cargo en $t7 DATA
daddi $t0, $0, 9            ; Cargo en $t0 el 9 para decirle a CONTROL que lea caracter
sd $t0, 0($t6)              ; Le paso a $t6 CONTROL el valor 9 para que sepa que debe leer un caracter
lbu $t1, 0($t7)             ; El caracter se guardo en DATA, lo lee guardandolo en $t1 LBU es para caracter
lbu $t2, cod_a($0)          ; Guardo en $t2 con LBU, el caracter de cod_a
bne $t1, $t2, dist          ; Si no son iguales, son distintos salta a dist
daddi $t3, $0, msj_igual    ; Si eran iguales, guarda en $t3 la direccion de msj_igual
j most                      ; Salta a la etiqueta de most
dist: daddi $t3, $0, msj_dist ; Si eran distintos, guarda en $t3 la direccion de msj_dist
most: sd $t3, 0($t7)        ; Le pasa a $t7 DATA, $t3 que tiene la direccion del mensaje a mostrar
daddi $t4, $0, 4            ; Se carga en $t4 el 4 para decirle a CONTROL que imprima un string
sd $t4, 0($t6)              ; Le paso a $t6 CONTROL el valor 4 para que sepa que debe imprimir un string
halt