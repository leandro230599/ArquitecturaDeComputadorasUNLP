9) Escribir un programa que implemente el siguiente fragmento escrito en un lenguaje de alto nivel:
   
   while a > 0 do begin
       x := x + y;
       a := a - 1;
   end;
  
   Ejecutar con la opción Delay Slot habilitada. 

    .data
A: .word 2
X: .word 2
Y: .word 3

    .code
lw r1, A(r0)
lw r2, X(r0)
lw r3, Y(r0)
loop: beqz r1, fin
	  dadd r2, r2, r3
	  sw r2, X(r0)
	  daddi r1, r1, -1
	  j loop
	  sw r1, A(r0)
fin: halt
