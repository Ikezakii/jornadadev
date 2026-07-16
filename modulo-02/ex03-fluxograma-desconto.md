# Exercício 3 — Fluxograma

Monte um fluxograma para o seguinte problema:

> "Uma loja dá desconto de 10% para compras acima de R$ 100. Leia o valor da compra e mostre o valor final a pagar."

> **Dica:** use o losango para a decisão (**Valor > 100?**) com os dois caminhos **Sim** e **Não**.

## Resolução

```mermaid
flowchart TD
    A[Início] --> B[Ler valor da compra]
    B --> C{Valor da compra > R$100?}
    C -->|Sim| D[Valor final = Valor da compra * 0,90]
    C -->|Não| E[Valor final = Valor da compra]
    D --> F[Exibir valor final]
    E --> F
    F --> G[Fim]
```