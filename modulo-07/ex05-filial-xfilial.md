Exercício 5 — A1_FILIAL e xFilial() ⭐ 🧠 (obrigatório)
Responda por escrito:

a. Por que existe o campo A1_FILIAL na tabela SA1 (e por que toda tabela do Protheus,
incluindo a ZA1 que criamos, precisa de um campo de filial)?
b. O que a função xFilial() tem a ver com isso? O que aconteceria se um programa
“escrevesse a filial na mão” em vez de usar xFilial() ?


Respostas

a -> Para permitir o controle de compartilhamento, a segregação de dados e a composição de índices do sistema

b -> Serve para retornar o código correto da filial de acordo com a regra de compartilhamento da tabela informada e a filial em que o usuário está logado.
Se um programa escreve a filial "na mão", ele perde a flexibilidade do sistema, gerando erros de gravação