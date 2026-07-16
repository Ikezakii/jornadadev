# Exercício 4 — Refinamento sucessivo

Aplique a técnica do refinamento sucessivo (visão geral → detalhamento) para o problema:

> Um sistema de caixa de supermercado deve registrar os itens de uma compra, calcular o subtotal, aplicar desconto se o cliente tiver cartão fidelidade (5%) e mostrar o total a pagar.

**Entregue dois níveis:** o **Nível 1** (visão geral, 3–4 passos) e o **Nível 2** (cada passo detalhado).

## Resolução

### Nível 1

1. Registrar itens da compra.
2. Calcular total.
3. Aplicar desconto se o cliente tem cartão fidelidade.
4. Mostrar valor total.

---

### Nível 2
 
1. Ler os valores de cada item passado no caixa.
2. Somar os valores (Valor total = N1 + N2 + N3.... + Nx).
3. Se o cliente tem cartão fidelidade → Valor total * 0,95. Senão "Sem desconto".
4. Mostrar valor da compra, valor do desconto (se houver) e valor total.