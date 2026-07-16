Exercício 2 — Pseudocódigo
Escreva em pseudocódigo um algoritmo para cada item:

a. Calcular a área de um retângulo (base × altura)
b. Verificar se um número é par ou ímpar
c. Encontrar o maior entre três números

(Dica: use as palavras Leia , Escreva , Se ... Senão e o operador ← para atribuir.)

Resolução

a.
ALGORITMO
REAL base, altura, area

base <- x
altura <- y

LEIA(base)
LEIA(altura)

area <- base * altura

ESCREVA("A área do retangulo é: {}", area)
FIMALGORITMO

b.
ALGORITMO
INTEIRO numero

numero <- x
LEIA(numero)

SE (numero % 2) == 0 ENTAO:
    ESCREVA("Número é par")
SENAO
    ESCREVA("Número é ímpar")
FIMSE
FIMALGORITMO

c.
ALGORITMO
INTEIRO n1, n2, n3, maior

n1 <- x
n2 <- y
n3 <- z

LEIA(n1,n2,n3)

maior <- n1

SE n2 > n1 E n2 > n3 ENTAO
    maior <- n2
SENAO
    SE n3 > n1 E n3 > n2 ENTAO
    maior <- n3
    FIMSE
FIMSE

ESCREVA("O maior número é: ", maior)
FIMALGORITMO

