FUNCTION Main()

    QOut("O Operador '=' compara se o começo deles são iguais, retornando .T. ou .F.")
    QOut("O Operador '==' compara se os valores são extamente iguais, retornando .T. ou .F.")

    QOut("Exemplos")
    QOut("Harbour = Harb --> " + HB_ValToExp("Harbour" = "Harb"))
    //QQOut("Harbour" = "Harb")
    QOut("")
    QOut("Harbour == Harb --> " + IIF("Harbour" == "Harb",".T.",".F.")) // Primeiro True dps False
    //QQOut("Harbour" == "Harb")

RETURN NIL

//HB_ValToExp() converte qualquer tipo pra string
// Segunda Opção usando o IIF ( Dica do servidor no Discord: fernandaluzx), poderia escolher oq quiser dentro do IIF, manter o padrão do programa né?