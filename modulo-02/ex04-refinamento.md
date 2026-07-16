Exercício 4 — Refinamento sucessivo
Aplique a técnica do refinamento sucessivo (visão geral → detalhamento) para o problema:

“Um sistema de caixa de supermercado deve registrar os itens de uma compra, calcular o
subtotal, aplicar desconto se o cliente tiver cartão fidelidade (5%) e mostrar o total a
pagar.”

Entregue dois níveis: o Nível 1 (visão geral, 3–4 passos) e o Nível 2 (cada passo detalhado).

Resolução:

Nivel 1:
Registrar itens da compra
calcular total
Aplicar desconto se o cliente tem cartão fidelidade
Mostrar valor total


Nivel 2:
Ler os valores de cada item passado no caixa
Somar os valores (Valor total = N1 + N2 + N3.... + Nx)
Se o cliente tem cartão fidelidade -> Valor total * 0,95. Senão "Sem desconto"
Mostrar valor da compra, valor do desconto (se houver) e valor total