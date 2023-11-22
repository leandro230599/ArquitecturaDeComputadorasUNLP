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
num: .double 5.4

.code
l.d f2, num($zero)
lwu $s6, DIR_CONTROL($zero)
lwu $s7, DIR_DATA($zero)
s.d f2, 0($s7)
daddi $t0, $zero, 3
sd $t0, 0($s6)
halt