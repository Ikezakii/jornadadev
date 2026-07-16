FUNCTION Main()

    LOCAL nValor
    LOCAL cNome
    LOCAL cData_nasc
    LOCAL dData_nasc
    LOCAL nIdade
    LOCAL nDesconto := 0
    LOCAL nValor_total
    SET DATE FORMAT TO "DD/MM/YYYY"

    INPUT "Digite o valor total da compra: R$" TO nValor

    ACCEPT "Digite o nome do cliente: " TO cNome

    ACCEPT "Digite a data de nascimento do cliente (dd/mm/aaaa): " TO cData_nasc
    dData_nasc := CToD(cData_nasc)//Era possivel fazer o usuário digitar separadamente a data,mes e ano também, sem a necessidade de usar "/"
    // Ou formatar a entrada crua (exemplo: 17092000)

    nIdade := INT((Date() - dData_nasc) / 365)

    IF nIdade > 60
        nDesconto := 0.875 // 100 - 12,5
        nValor_total := nValor * nDesconto
    ELSE
        nValor_total := nValor
    ENDIF

    QOut(Replicate("=", 35))
    QOut("        Resumo do Pedido")
    QOut(Replicate("=", 35))
    QOut("Nome do Cliente    : " + cNome)
    QOut("Idade              : " + alltrim(str(nIdade)))
    QOut("Valor do Pedido    : R$ " + allTrim(str(nValor, 10, 2)))
    IF nIdade > 60
        QOut("Desconto aplicado  : 12,5%")
    ELSE
        QOut("Desconto aplicado  : N/A")
    ENDIF
    QOut("Valor Total        : R$ " + allTrim(str(nValor_total, 10, 2)))
    QOut(Replicate("=", 35))
RETURN NIL

//Depois que começou a executar comandos, não pode mais declarar LOCAL.
