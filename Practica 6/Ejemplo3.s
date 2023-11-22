;  Leer dos numeros e imprimir la suma
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

.code
ld $t6, DIR_CONTROL($0)     ; Cargo en $t6 CONTROL
ld $t7, DIR_DATA($0)        ; Cargo en $t7 DATA
daddi $t0, $0, 8            ; Cargo en $t0 el 8 para decirle a CONTROL que lea

; Leer 2 numeros
sd $t0, 0($t6)              ; Le paso a $t6 CONTROL el valor 8 para que sepa que debe leer un numero
ld $t1, 0($t7)              ; El numero se guardo en DATA, lo lee guardandolo en $t1
sd $t0, 0($t6)              ; Le paso a $t6 CONTROL el valor 8 para que sepa que debe leer un numero
ld $t2, 0($t7)              ; El numero se guardo en DATA, lo lee guardandolo en $t2

; Sumo valores
dadd $t3, $t1, $t2          ; Se suma los valores de $t1 y $t2 guardando en $t3

; Guardo en DATA
sd $t3, 0($t7)              ; Se le pasa el resultado de la suma a $t7 DATA

; Imprimo
daddi $t5, $0, 1;           ; Se carga en $t5 el 1 para decirle a CONTROL que imprima entero sin signo
sd $t5, 0($t6)              ; Le paso a $t6 CONTROL el valor 1 para que sepa que debe imprimir entero sin signo
halt