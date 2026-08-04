Exercício 3 — Recriando a ZA1 no Configurador ️
No ambiente Protheus, recrie a tabela ZA1 no Configurador, com os campos definidos no
Exercício 2 (nome do pet, raça, data de nascimento, filial).

a. Cadastre a estrutura no dicionário (SX2/SX3).
b. Force o reconhecimento da tabela pelo framework (rotina de fórmulas, como foi mostrado
em aula).
c. Confira a estrutura final no MPSDU.


Passo a Passo
-> Entrar no SIGACFG

-> Base da dados -> Dicionario -> Base de Dados

-> "Incluir" -> colocar nome "ZA1", path "\DATA\"

-> Procurar por ZA1 no dicionario de dados -> ir adicionando os campos de nome, filiar etc... (com prefixo ZA1 e defininindo tipo e se é obrigatório)

-> Após salvar, entrar no SIGAMDI 

-> Atualizações - cadastros - formulas - "dbselectarea("ZA1")

-> Ir para o MPSDU - abrir arquivos \system\ sx2... e sx3...

-> em ambas procurar por ZA1