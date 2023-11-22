;   Imprimir entero sin signo
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
num: .word 5

.code
ld $t2, DIR_CONTROL($0)     ; Cargo en $t2 el CONTROL
ld $t3, DIR_DATA($0)        ; Cargo en $t3 el DATA
ld $t1, num($0)             ; Cargo en $t1 el numero
sd $t1, 0($t3)              ; Guardo en $t3 osea DATA, $t1 osea el numero
daddi $t1, $0, 1            ; Setea en 1 $t1
sd $t1, 0($t2)              ; Guardo en $t2 osea CONTROL, el valor 1 en $t1, esto es para indicar "imprime entero sin signo"
halt