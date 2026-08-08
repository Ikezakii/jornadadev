# TCC — Trabalho de Conclusão de Curso

### O Problema de Negócio
A Indústria XYZ precisa monitorar as não conformidades na entrada de materiais dos seus
fornecedores para se manter em conformidade com o processo de certificação ISO 9001.
Para isso, o sistema deve registrar: - Os certificados de qualidade dos fornecedores - As
ocorrências de não conformidade em cada entrega
A equipe de analistas já levantou os requisitos junto ao cliente e definiu o layout das tabelas e
as funcionalidades necessárias.



### Contexto das Tabelas
As rotinas e menus serão criados no módulo de Compras (SIGACOM) do Protheus.
As novas tabelas estarão vinculadas ao: - Cadastro de Fornecedores (tabela padrão SA2) -
Cadastro de Produtos (tabela padrão SB1)

# Descrição do Sistema

O sistema tem como objetivo realizar o **controle de fornecimento e o acompanhamento de ocorrências relacionadas aos fornecedores**, permitindo centralizar informações sobre certificados, validade, tolerância e registros de conformidade.

O sistema é dividido principalmente em duas tabelas:

### TABELA ZZ1 — Controle de Fornecimento

A tabela `ZZ1` armazena os controles de fornecimento dos fornecedores. Nela são registrados o fornecedor e sua loja, informações do certificado, validade do certificado, percentual de tolerância e os totais de itens conformes e não conformes.

O sistema também disponibiliza o nome do fornecedor automaticamente por meio do campo virtual `ZZ1_NOMEFO`, que consulta a tabela padrão `SA2`.

Além disso, a tabela possui índices para facilitar a localização dos registros por código, fornecedor e validade do certificado.



### Campos

| Título | Campo | Tipo | Tam | Dec | Contexto |
|---|---|---:|---:|---:|---|
| Filial | `ZZ1_FILIAL` | C | 2 | 0 | Real |
| Código | `ZZ1_CODIGO` | C | 6 | 0 | Real |
| Cód. Fornecedor | `ZZ1_FORNEC` | C | 6 | 0 | Real |
| Loja Fornecedor | `ZZ1_LOJAFO` | C | 2 | 0 | Real |
| Nome Fornecedor | `ZZ1_NOMEFO` | C | 40 | 0 | Virtual |
| Dados Certificado | `ZZ1_CERTIF` | C | 256 | 0 | Real |
| Val. Certificado | `ZZ1_VALCER` | D | 8 | 0 | Real |
| Tolerância (%) | `ZZ1_TOLERA` | N | 5 | 2 | Real |
| Qtd. Conforme | `ZZ1_TOTOK` | N | 12 | 2 | Real |
| Qtd. Não Conforme | `ZZ1_TOTNOK` | N | 12 | 2 | Real |

### Campos Virtuais

### ZZ1_NOMEFO

- POSICIONE("SA2", 1, xFilial("SA2") + M->ZZ1_FORNEC + M->ZZ1_LOJAFO, "A2_NOME")


----------
### Índices

| Ordem | Expressão | Descrição |
|---:|---|---|
| 1 | `ZZ1_FILIAL + ZZ1_CODIGO` | Chave primária |
| 2 | `ZZ1_FILIAL + ZZ1_FORNEC + ZZ1_LOJAFO` | Por fornecedor |
| 3 | `ZZ1_FILIAL - DTOS(ZZ1_VALCER)` | Por validade do certificado |

---
## Gatilhos — ZZ1
| Origem | Destino | Regra |
|---|---|---|
| `ZZ1_FORNEC` | `ZZ1_NOMEFO` | `POSICIONE("SA2",1,xFilial("SA2")+M->ZZ1_FORNEC+M->ZZ1_LOJAFO,"A2_NOME")` |


# Rotinas da STTZZ1 

A função `STTZZ1()` é responsável por abrir e configurar o cadastro de certificados da tabela `ZZ1`.

## Inicialização

A rotina começa selecionando a área de trabalho da tabela `ZZ1` e definindo o índice que será utilizado pelo `mBrowse`:

```advpl
DbSelectArea("ZZ1")
ZZ1->(DbSetOrder(1))

```

O índice utilizado é o índice 1 da tabela, cuja chave é:

```text
ZZ1_FILIAL + ZZ1_CODIGO

```

Também são declaradas as variáveis utilizadas pela rotina:

```advpl
LOCAL oErro
LOCAL aCores := {}
PRIVATE aRotina := {}
PRIVATE cCadastro := "Cadastro de Certificados"

```

A variável `cCadastro` define a identificação do cadastro, enquanto `aRotina` armazena as opções disponíveis no menu.

----------

## Menu de Operações

O menu é configurado por meio da variável `aRotina`:

```advpl
aRotina := {;
    {"Pesquisar", "AxPesqui", 0, 1},;
    {"Visualizar", "AxVisual", 0, 2},;
    {"Incluir", "AxInclui", 0, 3},;
    {"Alterar", "AxAltera", 0, 4},;
    {"Excluir", "AxDeleta", 0, 5},;
    {"Ocorrências", "U_STTZZ2FLT", 0, 6};
}

```


| Opção | Função | Finalidade |
|---|---|---|
| Pesquisar | `AxPesqui` | Pesquisa |
| Visualizar | `AxVisual` | Visualização |
| Incluir | `AxInclui` | Inclusão |
| Alterar | `AxAltera` | Alteração |
| Excluir | `AxDeleta` | Exclusão |
| Ocorrências | `U_STTZZ2FLT` | Consulta de ocorrências |

A opção **Ocorrências** utiliza uma função desenvolvida especificamente para o sistema. Ela recebe o código do controle selecionado na `ZZ1` e permite consultar as ocorrências correspondentes na tabela `ZZ2`.

----------

## Legendas dos Certificados

A rotina também configura cores para facilitar a identificação da situação dos certificados:

```advpl
aCores := {;
    { "ZZ1_VALCER < dDataBase", "BR_VERMELHO" },;
    { "ZZ1_VALCER <= dDataBase + 30", "BR_AMARELO" },;
    { "ZZ1_VALCER > dDataBase + 30", "BR_VERDE" };
}

```
| Cor | Condição | Situação |
|---|---|---|
| Vermelho | `ZZ1_VALCER < dDataBase` | Vencido |
| Amarelo | `ZZ1_VALCER <= dDataBase + 30` | Vence em até 30 dias |
| Verde | `ZZ1_VALCER > dDataBase + 30` | Dentro da validade |

Assim, o usuário consegue identificar rapidamente quais certificados estão vencidos ou próximos do vencimento.

----------

## Abertura do Browse

Após a configuração da tabela e das opções do sistema, o `mBrowse` é utilizado para apresentar os registros:

```advpl
mBrowse(6,1,22,75,"ZZ1")

```

O browse apresenta os registros da `ZZ1` e disponibiliza as operações configuradas na variável `aRotina`.

----------

## Tratamento de Erros

A rotina utiliza `BEGIN SEQUENCE ... RECOVER USING` para tratar possíveis erros durante sua execução:

```advpl
RECOVER USING oErro

    U_GravarLogTCC("STTZZ1",oErro)

    MsgStop("Erro ao abrir cadastro de certificados")

```

Caso ocorra uma exceção, o objeto `oErro` recebe as informações do erro. Essas informações são enviadas para a função `U_GravarLogTCC()`, responsável pelo registro do problema, e posteriormente uma mensagem é exibida ao usuário.

Dessa forma, a rotina evita que uma falha inesperada encerre o processo sem fornecer uma resposta ao usuário.
### TABELA ZZ2 — Ocorrências

A tabela `ZZ2` registra as ocorrências relacionadas aos controles cadastrados na `ZZ1`. Cada ocorrência possui informações como fornecedor, data e hora, produto, quantidade conforme, quantidade não conforme e valor unitário.

Os campos virtuais `ZZ2_NOMEFO`, `ZZ2_TOTOK` e `ZZ2_TOTNOK` permitem apresentar informações calculadas automaticamente, evitando a necessidade de armazenar esses valores diretamente na tabela.

### Campos

| Título | Campo | Tipo | Tam | Dec | Contexto |
|---|---|---:|---:|---:|---|
| Filial | `ZZ2_FILIAL` | C | 2 | 0 | Real |
| Controle (→ZZ1) | `ZZ2_CONFOR` | C | 6 | 0 | Real |
| Cód. Fornecedor | `ZZ2_FORNEC` | C | 6 | 0 | Real |
| Loja Fornecedor | `ZZ2_LOJAFO` | C | 2 | 0 | Real |
| Nome Fornecedor | `ZZ2_NOMEFO` | C | 40 | 0 | Virtual |
| Data Ocorrência | `ZZ2_DATA` | D | 8 | 0 | Real |
| Hora | `ZZ2_HORA` | C | 5 | 0 | Real |
| Produto | `ZZ2_CODPRO` | C | 15 | 0 | Real |
| Qtde. Conforme | `ZZ2_QTDOK` | N | 12 | 0 | Real |
| Qtde. Não Conforme | `ZZ2_QTDNOK` | N | 12 | 0 | Real |
| Valor Unitário | `ZZ2_VLRUNI` | N | 12 | 2 | Real |
| R$ Conforme | `ZZ2_TOTOK` | N | 12 | 2 | Virtual |
| R$ Não Conforme | `ZZ2_TOTNOK` | N | 12 | 2 | Virtual |
---

### Campos Virtuais

### ZZ2_NOMEFO

- POSICIONE("SA2", 1, xFilial("SA2") + M->ZZ2_FORNEC + M->ZZ2_LOJAFO, "A2_NOME")

###   ZZ2_TOTNOK

- ZZ2_TOTOK = M->ZZ2_QTDOK * M->ZZ2_VLRUNI

### ZZ2_TOTOK
- ZZ2_TOTNOK = M->ZZ2_QTDNOK * M->ZZ2_VLRUNI


### Índices

| Ordem | Expressão | Descrição |
|---:|---|---|
| 1 | `ZZ2_FILIAL + ZZ2_CONFOR + DTOS(ZZ2_DATA) + ZZ2_HORA` | Chave primária |
| 2 | `ZZ2_FILIAL + ZZ2_FORNEC + ZZ2_LOJAFO + DTOS(ZZ2_DATA)` | Por fornecedor e data |
| 3 | `ZZ2_FILIAL + DTOS(ZZ2_DATA)` | Por data |
## Gatilhos — ZZ2

| Origem | Destino | Regra |
|---|---|---|
| `ZZ2_CONFOR` | `ZZ2_FORNEC` | `POSICIONE("ZZ1",1,xFilial("ZZ1")+M->ZZ2_CONFOR,"ZZ1_FORNEC")` |
| `ZZ2_CONFOR` | `ZZ2_LOJAFO` | `POSICIONE("ZZ1",1,xFilial("ZZ1")+M->ZZ2_CONFOR,"ZZ1_LOJAFO")` |
| `ZZ2_CONFOR` | `ZZ2_NOMEFO` | `POSICIONE("SA2",1,xFilial("SA2")+M->ZZ2_FORNEC+M->ZZ2_LOJAFO,"A2_NOME")` |
| `ZZ2_DATA` | `ZZ2_DATA` | `IF(INCLUI, dDataBase, ZZ2->ZZ2_DATA)` |
| `ZZ2_HORA` | `ZZ2_HORA` | `IF(INCLUI, Time(), ZZ2->ZZ2_HORA)` |
# Rotinas da ZZ2

A tabela `ZZ2` possui duas rotinas principais para exibição das ocorrências: `STTZZ2`, responsável pela abertura geral do cadastro de ocorrências, e `STTZZ2FLT`, responsável por abrir as ocorrências filtradas a partir de um controle específico da tabela `ZZ1`.

## STTZZ2 — Browse de Ocorrências

A função `STTZZ2()` é responsável por abrir o `mBrowse` da tabela `ZZ2`.

Inicialmente, a rotina seleciona a área de trabalho da tabela e define o primeiro índice:

```advpl
DbSelectArea("ZZ2")
ZZ2->(DbSetOrder(1))

```

Em seguida, são definidas as regras de cores do browse por meio da variável `aCores`. A cor do registro é determinada de acordo com o percentual de itens não conformes e a tolerância definida para o controle correspondente na `ZZ1`.

```advpl
aCores := {;
    { "U_PercNaoConforme(ZZ2_QTDOK,ZZ2_QTDNOK) > U_ToleranciaZZ1(ZZ2_CONFOR)", "BR_VERMELHO" },;
    { "U_PercNaoConforme(ZZ2_QTDOK,ZZ2_QTDNOK) <= U_ToleranciaZZ1(ZZ2_CONFOR)", "BR_VERDE" };
}

```

A lógica utilizada é:

-   **Vermelho:** percentual de não conformidade acima da tolerância permitida.
    
-   **Verde:** percentual de não conformidade dentro da tolerância permitida.
    

Por fim, o `mBrowse` é aberto utilizando a tabela `ZZ2` e as regras de cores:

```advpl
mBrowse(1,1,22,75,"ZZ2",,,,,,aCores)

```

A rotina também possui um bloco `BEGIN SEQUENCE`, permitindo tratar possíveis erros durante a execução. Caso ocorra uma exceção, o erro é registrado por meio da função `U_GravarLogTCC()` e uma mensagem é apresentada ao usuário.

----------

## STTZZ2FLT — Browse Filtrado

A função `STTZZ2FLT(cCodigoZZ1)` é utilizada para abrir o cadastro de ocorrências **filtrado por um controle específico da `ZZ1`**.

Ela recebe como parâmetro o código do controle da `ZZ1`:

```advpl
USER FUNCTION STTZZ2FLT(cCodigoZZ1)

```

Com esse código, é montada uma expressão de filtro:

```advpl
cFiltro := "ZZ2_CONFOR == '" + cCodigoZZ1 + "'"

```

Dessa forma, somente os registros da `ZZ2` cujo campo `ZZ2_CONFOR` corresponde ao código recebido são apresentados.

O filtro é aplicado por meio da função `FilBrowse()`:

```advpl
FilBrowse("ZZ2",@aIndexZZ2,@cFiltro)

```

A variável `aIndexZZ2` armazena as informações necessárias para posteriormente restaurar o estado original do browse.

Depois da aplicação do filtro, o `mBrowse` é aberto:

```advpl
mBrowse(1,1,22,75,"ZZ2")

```

Após o encerramento do browse, o filtro é removido através de:

```advpl
EndFilBrw("ZZ2",aIndexZZ2)

```

Isso garante que o filtro aplicado para aquela consulta não permaneça ativo posteriormente.

### Fluxo da rotina

O funcionamento pode ser resumido da seguinte forma:

```text
Código da ZZ1
     ↓
STTZZ2FLT(cCodigoZZ1)
     ↓
Monta filtro:
ZZ2_CONFOR == cCodigoZZ1
     ↓
FilBrowse()
     ↓
Abre mBrowse da ZZ2
     ↓
Usuário consulta as ocorrências
     ↓
EndFilBrw()
     ↓
Filtro é removido

```

Dessa forma, a `STTZZ2FLT()` permite acessar rapidamente as ocorrências relacionadas a um determinado controle de fornecimento, evitando que o usuário precise localizar manualmente os registros correspondentes na tabela `ZZ2`.

## Tratamento de erros

As duas rotinas utilizam `BEGIN SEQUENCE ... RECOVER USING` para tratar erros de execução.

Em caso de erro, a exceção é armazenada em `oErro`, registrada pela função:

```advpl
U_GravarLogTCC("STTZZ2",oErro)

```

ou:

```advpl
U_GravarLogTCC("STTZZ2FLT",oErro)

```

e posteriormente uma mensagem é apresentada ao usuário.

Esse tratamento evita que um erro inesperado encerre a execução da rotina sem uma mensagem adequada e permite manter um registro do problema para análise posterior.

# Biblioteca de Funções — STTZZLIB

A `STTZZLIB` reúne funções auxiliares utilizadas pelas rotinas do sistema, centralizando operações de consulta, cálculo, validação e tratamento de erros.

Entre as principais funções estão:

| Função | Finalidade |
|---|---|
| `NomeFornecedor()` | Busca o fornecedor na `SA2`. |
| `NomeProduto()` | Busca o produto na `SB1`. |
| `PercNaoConforme()` | Calcula o percentual de não conformidade. |
| `CertificadoVencendo()` | Verifica vencimento em até 30 dias. |
| `GravarLogTCC()` | Registra erros no console. |
| `ToleranciaZZ1()` | Busca a tolerância da `ZZ1`. |
| `ValidaZZ1()` | Valida a `ZZ1`. |
| `ValidaZZ2()` | Valida a `ZZ2`. |
| `PodeExcluirZZ1()` | Impede exclusão com ocorrências vinculadas. |

A biblioteca reúne funções reutilizáveis, evitando repetição de código e facilitando a manutenção.

## Validações Obrigatórias

| Tabela | Campo | Validação |
|---|---|---|
| `ZZ1` | `ZZ1_FORNEC` | Deve existir na `SA2`. |
| `ZZ1` | `ZZ1_VALCER` | Não pode ser inferior à data atual na inclusão. |
| `ZZ1` | `ZZ1_TOLERA` | Deve estar entre 0 e 100. |
| `ZZ2` | `ZZ2_CONFOR` | Deve existir na `ZZ1`. |
| `ZZ2` | `ZZ2_CODPRO` | Deve existir na `SB1`. |
| `ZZ2` | `ZZ2_DATA` | Não pode ser uma data futura. |
# Guia de Instalação

## 1. Arquivos necessários

O projeto possui os seguintes arquivos:


| Arquivo | Finalidade |
|---|---|
| `sa1990.dbf` | Dados da `SA1` |
| `sa2990.dbf` / `.csv` | Dados da `SA2` |
| `six990.dbf` / `.csv` | Índices |
| `sx2990.dbf` / `.csv` | Dicionário de tabelas |
| `sx3990.dbf` / `.csv` | Dicionário de campos |
| `sx7990.dbf` / `.csv` | Gatilhos |
| `sxb990.dbf` / `.csv` | Consultas |
| `zz1990.dbf` / `.csv` | Tabela `ZZ1` |
| `zz2990.dbf` / `.csv` | Tabela `ZZ2` |
| `sigacom.xnu` | Menu do `SIGACOM` |
| `*.PRW` / `*.PRG` | Rotinas e bibliotecas do sistema |


----------

## 2. Instalação

### 1. Arquivos DBF

Copiar os arquivos `.DBF` para a pasta de dados do ambiente Protheus.

Os principais arquivos utilizados pelo projeto são:

```text
zz1990.dbf
zz2990.dbf
sa1990.dbf
sa2990.dbf

```

### 2. Dicionário

Carregar/configurar no Protheus os arquivos:

```text
sx2990.dbf
sx3990.dbf
sx7990.dbf
six990.dbf
sxb990.dbf

```

Eles correspondem ao dicionário, campos, gatilhos, índices e consultas utilizados pelo sistema.

### 3. Rotinas

Copiar e compilar as rotinas `.PRW`  do projeto no ambiente Protheus.

A biblioteca `STTZZLIB` também deve ser compilada, pois contém funções utilizadas pelas demais rotinas.

Principais rotinas:


| Rotina | Função |
|---|---|
| `STTZZ1` | Cadastro de certificados |
| `STTZZ2` | Cadastro de ocorrências |
| `STTZZ2FLT` | Consulta filtrada de ocorrências |
| `STTZZLIB` | Biblioteca de funções auxiliares |

### 4. Menu

Importar o arquivo:

```text
sigacom.xnu

```

no módulo `SIGACOM`.

    