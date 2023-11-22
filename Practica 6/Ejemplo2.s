;   Realizar una suma y mostrarlo en pantalla, luego una resta y mostrar en pantalla
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
num2: .word 10

.code
ld $t2, DIR_CONTROL($0)     ; Cargo en $t2 el CONTROL
ld $t3, DIR_DATA($0)        ; Cargo en $t3 el DATA
ld $t0, num($0)             ; Cargo en $t1 el num
ld $t1, num2($0)            ; Cargo en $0 el num2
dadd $t4, $t0, $t1          ; Guardo en $t4 la suma de $t0 y $t1
sd $t4, 0($t3)              ; Guardo en $t3 osea DATA, $t4 osea el resultado de la suma
daddi $t4, $0, 2            ; Setea en 2 $t4 para imprimir entero con signo 
sd $t4, 0($t2)              ; Guardo en $t2 osea CONTROL, el valor 2 de $t4, esto es para indicar "imprime entero con signo"
dsub $t4, $t0, $t1          ; Guardo en $t4 la resta entre $t0 y $t1
sd $t4, 0($t3)              ; Guardo en $t3 osea DATA, $t4 osea el resultado de la resta
daddi $t4, $0, 2            ; Setea en 2 $t4 para imprimir entero con signo 
sd $t4, 0($t2)              ; Guardo en $t2 osea CONTROL, el valor 2 de $t4, esto es para indicar "imprime entero con signo"
halt