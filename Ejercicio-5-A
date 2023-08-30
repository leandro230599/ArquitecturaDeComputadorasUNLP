ORG 1000h
  A dw 5h
  B dw 6h
  C dw 2h
  D dw ?

org 2000h
  mov ax, A
  add ax, B
  sub ax, C
  mov bx, offset D
  mov [bx], ax
  hlt
end
