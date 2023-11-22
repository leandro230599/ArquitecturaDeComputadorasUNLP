;   Escriba un programa que realice la suma de dos números enteros (de un dígito cada uno) utilizando dos subrutinas: La
;   denominada ingreso del ejercicio anterior (ingreso por teclado de un dígito numérico) y otra denominada
;   resultado, que muestre en la salida estándar del simulador (ventana Terminal) el resultado numérico de la suma de
;   los dos números ingresados (ejercicio similar al ejercicio 7 de Práctica 2). 

;   CONTROL = 1 Imprime entero sin signo (poner numero en DATA) SALIDA ALFANUMERICA
;             2 Imprime entero con signo (poner numero en DATA) SALIDA ALFANUMERICA
;             3 Imprime un punto flotante (poner numero en DATA) SALIDA ALFANUMERICA
;             4 Imprime un string (asciiz) (poner direccion string en DATA) SALIDA ALFANUMERICA
;             5 Cambia el color de un pixel de la pantalla grafica (DATA a DATA+3 RGBA, DATA+4 Coordenada Y, DATA+5 Coordenada X) SALIDA GRAFICA
;             6 Limpia la pantalla alfanumerica (DATA no recibe nada) SALIDA ALFANUMERICA
;             7 Limpia la pantalla grafica (DATA no recibe nada)  SALIDA GRAFICA
;             8 Lee un numero (sin coma se guarda como entero, con coma como flotante) (Buscar el numero en DATA) ENTRADA TECLADO
;             9 Lee un caracter (Uno solo, y no hace falta pulsar enter) (Buscar el caracter en DATA, leer con LBU) ENTRADA TECLADO

.data
msj: .asciiz "No valido"
DIR_CONTROL: .word 0x10000
DIR_DATA: .word 0x10008

.code
ld $s0, DIR_CONTROL($0)                         ; Cargo en $s0 CONTROL
ld $s1, DIR_DATA($0)                            ; Cargo en $s1 DATA
daddi $sp, $zero, 0x400                         ; Inicio la pila
jal ingreso                                     ; Salto a la subrutina ingreso
dadd $t0, $zero, $v0                            ; Guardo en $t0 el retorno de la subrutina ingreso $v0 que tiene 1 si es valido, 0 sino
dadd $s2, $zero, $v1                            ; Guardo en $s2 el retorno de la subrutina ingreso $v1 que tiene el digito
beqz $t0, fin_programa
jal ingreso
dadd $t0, $zero, $v0                            ; Guardo en $t0 el retorno de la subrutina ingreso $v0 que tiene 1 si es valido, 0 sino
dadd $s3, $zero, $v1                            ; Guardo en $s2 el retorno de la subrutina ingreso $v1 que tiene el digito
beqz $t0, fin_programa
dadd $a0, $zero, $s2
dadd $a1, $zero, $s3
jal resultado                                   ; Salto a la subrutina resultado
fin_programa: halt

ingreso: daddi $t0, $zero, 8                    ; Guardo en $t0 el 8 para que lea un numero al pasarselo a CONTROL
         daddi $v0, $zero, 0                    ; Guardo en $v0 el retorno de la subrutina 0 por defecto
         sd $t0, 0($s0)                         ; Le paso $t0 el 8 a CONTROL para que se ingrese numero de teclado
         ld $t1, 0($s1)                         ; Leo en $t1 el numero ingresado que esta en DATA
         daddi $t3, $t1, 0x30                   ; Al numero le sumo 30H, y lo guardo en $t3, era para verificar el ascii pero no sirve, podria hacerse sin esta linea y sin sumar 30H
         slti $t2, $t3, 0x3A                    ; Verifico que $t3 sea menor a 3AH, podria ser tambien que sea menor a Ah osea menor a 10 decimal, que sea hasta 9 el digito
         beqz $t2, no_valido                    ; En $t2 se guardo 1 si es menor o 0 si es mayor o igual, entonces salgo si es 0 a no_valido
         slti $t2, $t3, 0x30                    ; Verifico si $t3 es menor a 30H o podria ser 0 tambien sin todo esto del 0x30
         bnez $t2, no_valido                    ; Si $t2 es 1 es porque es menor a 0 o 30H, entonces no es valdo y salto
         daddi $v0, $v0, 1                      ; Si esta aca es porque es valido, suma al retorno 1 que significara que es valido
         dadd $v1, $zero, $t1                   ; a $v1 le paso el  
         j fin                                  ; Salto a fin
         no_valido: daddi $t2, $zero, msj       ; Carga en $t2 la direccion de msj
                    sd $t2, 0($s1)              ; Le pasa a DATA la direccion de msj
                    daddi $t2, $zero, 4         ; Carga en $t2 el codigo 4 
                    sd $t2, 0($s0)              ; Se lo pasa a CONTROL e imprime msj
         fin: jr $ra                            ; Vuelvo de la subrutina

resultado: dadd $t0, $a0, $a1
           sd $t0, 0($s1)
           daddi $t0, $zero, 1
           sd $t0, 0($s0)
           jr $ra