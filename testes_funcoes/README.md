# Biblioteca de Funções Harbour

Biblioteca de funções auxiliares desenvolvida em Harbour para validação de entradas do usuário.

O objetivo é reutilizar essas funções em diferentes projetos, evitando duplicação de código e centralizando as validações.

---

# Estrutura

```
funcoes/

├── ano_bis.prg
├── dia_no_mes.prg

├── validar_data.prg
├── validar_ano.prg
├── validar_mes.prg
├── validar_dia.prg

├── validar_int.prg
├── validar_decimal.prg
└── validar_texto.prg
```

---

# Dependências

A função `validar_data()` utiliza outras funções da biblioteca.

```
validar_data()
        │
        ├── validar_ano()
        ├── validar_mes()
        └── validar_dia()
                │
                └── dias_no_mes()
                        │
                        └── ano_bis()
```

---

# Funções

## validar_num_int()

Valida números inteiros.

### Parâmetros

|Parâmetro|Descrição|
|----------|---------|
|cNum|Texto contendo o número informado pelo usuário|
|lAceita_null|Permite campo vazio|
|nLimite|Quantidade máxima de dígitos|
|lAceita_negativo|Permite números negativos|

### Retorno

```
.T.
```

Número válido.

ou

```
.F.
```

Número inválido.

### Exemplo

```harbour
LOCAL cIdade

ACCEPT "Idade: " TO cIdade

IF validar_num_int(cIdade,.F.,3)
    ? "Idade válida"
ENDIF
```

---

## validar_num_dec()

Valida números decimais.

Aceita:

```
10
10.5
10.50
-25.80
```

Não aceita:

```
abc
12a
10..5
```

### Parâmetros

|Parâmetro|Descrição|
|----------|---------|
|cNum|Número informado|
|lAceita_null|Permite campo vazio|
|lAceita_negativo|Permite números negativos|

Retorna `.T.` ou `.F.`.

---

## validar_texto()

Valida textos.

Características:

- aceita letras;
- aceita caracteres acentuados;
- aceita espaço;
- pode limitar tamanho;
- pode impedir números e caracteres especiais.

### Parâmetros

|Parâmetro|Descrição|
|----------|---------|
|cTexto|Texto informado|
|nLimite|Quantidade máxima de caracteres|
|lAceita_null|Permite campo vazio|
|lAceita_num_especial|Permite números e caracteres especiais|

---

## validar_data()

Solicita ao usuário:

```
Ano
Mês
Dia
```

Realiza todas as validações necessárias.

Retorna um valor do tipo:

```
DATE
```

### Exemplo

```harbour
LOCAL dNascimento

dNascimento := validar_data()
```

---

## validar_ano()

Solicita um ano válido.

Valida:

- somente números;
- exatamente quatro dígitos;
- ano menor ou igual ao ano atual.

---

## validar_mes()

Solicita um mês válido.

Valida:

```
1 até 12
```

---

## validar_dia()

Solicita um dia válido considerando:

- mês informado;
- ano informado;
- anos bissextos.

---

## dias_no_mes()

Retorna a quantidade máxima de dias de um mês.

Exemplo:

```
02/2024 -> 29
02/2025 -> 28
04 -> 30
05 -> 31
```

---

## ano_bis()

Verifica se um ano é bissexto.

Retorna:

```
.T.
```

ou

```
.F.
```

---

# Utilização

Basta compilar todos os arquivos `.prg` juntamente com o programa principal.

Exemplo de estrutura:

```
Projeto/

main.prg

funcoes/
    validar_int.prg
    validar_decimal.prg
    validar_texto.prg
    validar_data.prg
    ...
```

Depois basta chamar normalmente:

```harbour
LOCAL dData
LOCAL cNome

dData := validar_data()

IF validar_texto(cNome)
    ...
ENDIF
```

Não é necessário copiar as funções para dentro do arquivo principal.

---

# Observações

- As funções foram desenvolvidas para trabalhar principalmente com entradas realizadas utilizando `ACCEPT`.
- Recomenda-se validar primeiro e converter depois (`Val()`, `CTOD()`, etc.).
- As funções retornam valores simples (`.T.`, `.F.` ou `DATE`).

---

# Futuras melhorias

- Permitir retorno ao campo anterior durante validação de datas.
- E outras que não enxerguei sozinho