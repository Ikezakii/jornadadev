# 📝 Exercício 2 — A tabela ZA1 (Pets) ⭐🧠

> **Em aula, criamos do zero a tabela customizada `ZA1`, para cadastro de Pets.**

---

# ✅ Respostas

## 🔹 a. Liste os campos da ZA1 (nome do campo, tipo, tamanho)

| Campo | Tipo | Tamanho |
| :----- | :--: | :------: |
| `ZA1_FILIAL` | Caracter | 2 dígitos |
| `ZA1_NOME` | Caracter | 30 dígitos |
| `ZA1_RACA` | Caracter | 30 dígitos |
| `ZA1_DATA` | Data | 8 dígitos |

---

## 🔹 b. Que índice faria sentido para a ZA1? Justifique.

> `ZA1_FILIAL + ZA1_NOME`, com essas duas informações é possível achar os pets de forma única dentro de uma filial, consulta por nome sendo mais comum e simples.

---

## 🔹 c. Explique por que o prefixo da tabela é `Z`.

> É o padrão de prefixo para tabelas criadas pelo usuário, não vieram por padrão com o Protheus.

---

## 🔹 d. Explique por que os campos começam com `ZA1_` (ex: `ZA1_NOME`, `ZA1_RACA`) e não apenas com o nome do campo.

> Esse prefixo nos campos serve para o Protheus indentificar de qual tabela os campos pertencem.