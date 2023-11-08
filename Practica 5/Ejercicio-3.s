3)  Escribir un programa que calcule la superficie de un triángulo rectángulo de base 5,85 cm y altura 13,47 cm.
    Pista: la superficie de un triángulo se calcula como:
        Superficie = (base x altura) / 2 

.data
base:   .double 5.85
altura: .double 13.47
res:    .double 0.0

.code
l.d     f1, base(r0)
l.d     f2, altura(r0)
l.d     f3, res(r0)
daddi   r1, r1,         2
mtc1    r1, f4
cvt.d.l f5, f4
mul.d   f6, f1,         f2
div.d   f7, f6,         f5
s.d     f7, res(r0)
halt      
