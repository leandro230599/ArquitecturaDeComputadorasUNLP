4)  El índice de masa corporal (IMC) es una medida de asociación entre el peso y la talla de un individuo.
    Se calcula a partir del peso (expresado en kilogramos, por ejemplo: 75,7 kg) y la estatura (expresada en metros,
    por ejemplo 1,73 m), usando la fórmula:
    
        IMC = peso / (estatura)^2

    De acuerdo al valor calculado con este índice, puede clasificarse el estado nutricional de una persona en:
    Infrapeso (IMC < 18,5), Normal (18,5 ≤ IMC < 25), Sobrepeso (25 ≤ IMC < 30) y Obeso (IMC ≥ 30).
    Escriba un programa que dado el peso y la estatura de una persona calcule su IMC y lo guarde en la dirección
    etiquetada IMC. También deberá guardar en la dirección etiquetada estado un valor según la siguiente tabla:
    
  |---------------------------------------------|
  | IMC       Clasificación     Valor guardado  |
  |---------------------------------------------|
  | < 18,5      Infrapeso            1          |
  | < 25        Normal               2          |
  | < 30        Sobrepeso            3          |
  | ≥ 30        Obeso                4          |
  |---------------------------------------------|

  .data
peso:       .double 75.7
altura:     .double 1.73
imc:        .double 0.0
estado:     .word   0
infrapeso:  .double 18.5
normal:     .double 25.0
sobrepeso:  .double 30.0

.code
    l.d     f1,         peso(r0)
    l.d     f2,         altura(r0)
    l.d     f3,         imc(r0)
    l.d     f10,        infrapeso(r0)
    l.d     f11,        normal(r0)
    l.d     f12,        sobrepeso(r0)
    mul.d   f2,         f2,             f2              ; Probando
    div.d   f4,         f1,             f2
    s.d     f4,         imc(r0)
    c.lt.d  f4,         f10
    bc1f    siguiente
    daddi   r1,         r0,             1
    j       fin
siguiente:      c.lt.d  f4,         f11
    bc1f    siguiente2
    daddi   r1,         r0,             2
    j       fin
siguiente2:     c.lt.d  f4,         f12
    bc1f    siguiente3
    daddi   r1,         r0,             3
    j       fin
siguiente3:     daddi   r1,         r0,             4
fin:            sw      r1,         estado(r0)
    halt    
