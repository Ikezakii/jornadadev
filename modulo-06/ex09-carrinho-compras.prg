FUNCTION Main()

    LOCAL aCompras := {}
    LOCAL cNome_produto
    LOCAL cPreco
    LOCAL nTotal := 0
    LOCAL nPreco
    LOCAL compras
    LOCAL nCont := 0

    DO WHILE .T.
        nCont++
        QOut(Replicate("=",35))
        DO WHILE .T.
            ACCEPT "Digite o Nome do produto ou digite 'sair' para encerrar: " TO cNome_produto
            IF validar_texto(cNome_produto,NIL, .F., .T.)
                IF alltrim(lower(cNome_produto)) == "sair"
                    EXIT
                ELSE
                    AADD(aCompras,{})
                    AADD(aCompras[nCont],cNome_produto)
                    EXIT
                ENDIF
            ELSE
                QOut("Digite um produto válido")
            ENDIF
        END DO
        
        IF alltrim(lower(cNome_produto)) == "sair"
            EXIT
        ENDIF

        QOut(Replicate("=",35))
        DO WHILE .T.
            ACCEPT "Digite o preço do produto: " TO cPreco
            IF validar_num(cPreco, .F., .F., .T., NIL, 0.1)
                nPreco := Val(cPreco)
                AADD(aCompras[nCont],nPreco)
                EXIT
            ELSE
                QOut("Digite um preço válido")
            ENDIF
        END DO
    END DO

    QOut(Replicate("=",35))
    QOut("Resumo do pedido")
    Qout("")
    FOR EACH compras IN aCompras
        nTotal += compras[2]
        QOut(compras[1] + " --- " + "R$" + alltrim(str(compras[2],10,2)))
    NEXT
    QOut("")
    QOut("Total --- " + "R$" + alltrim(str(nTotal,10,2)))
    QOut(Replicate("=",35))


RETURN NIL




FUNCTION validar_num(cNum, lAceita_null , lAceita_negativo, lAceita_dec,nLimite_val, nMin_val)
    LOCAL index
    LOCAL lPonto := .F.
    LOCAL nPos := 0
    LOCAL lTem_num := .F.
    LOCAL nValor

    cNum := AllTrim(cNum)

    IF lAceita_null == NIL
        lAceita_null := .F.
    ENDIF

    IF lAceita_dec == NIL
        lAceita_dec := .F.
    ENDIF

    IF lAceita_negativo == NIL
        lAceita_negativo := .F.
    ENDIF

    IF lAceita_null == .F.
        IF EMPTY(cNum)
            RETURN .F.
        ENDIF
    ENDIF


    FOR EACH index IN cNum
        nPos++
        IF index == "-"
            IF lAceita_negativo == .T. .AND. nPos == 1
                LOOP
            ELSE
                RETURN .F.
            ENDIF
        ENDIF

        IF index == "."
            IF lAceita_dec .AND. !lPonto
                lPonto := .T.
                LOOP
            ELSE
                RETURN .F.
            ENDIF
        ENDIF

        IF AT(index,"0123456789") > 0
            lTem_num := .T.
            LOOP
        ENDIF

    END FOR

    IF lTem_num == .F.
        RETURN .F.
    ENDIF

    nValor := Val(cNum)

    IF nMin_val != NIL
        IF nValor < nMin_val
            RETURN .F.
        ENDIF
    ENDIF

    IF nLimite_val != NIL
        IF nValor > nLimite_val
            RETURN .F.
        ENDIF
    ENDIF

RETURN .T.

FUNCTION validar_texto(cTexto,nLimite,lAceita_null,lAceita_num_especial)

    LOCAL index

    IF lAceita_null == NIL
        lAceita_null := .F.
    ENDIF

    IF lAceita_num_especial == NIL
        lAceita_num_especial := .F.
    ENDIF

    IF nLimite == NIL
        nLimite := 30
    ENDIF

    IF nLimite < 1
        nLimite := 1
    ENDIF


    IF lAceita_null == .F.
        IF EMPTY(alltrim(cTexto))
            RETURN .F.
        ENDIF
    ENDIF

    IF len(alltrim(cTexto)) > nLimite
        RETURN .F.
    ENDIF

    IF lAceita_num_especial == .F.
        FOR EACH index IN UPPER(alltrim(cTexto))
            IF AT(index, "QWERTYUIOPASDFGHJKLÇZXCVBNMÁÉÍÓÚÀÂÃÕÊÔ ") == 0
                RETURN .F.
            ENDIF
        END FOR
    ENDIF

RETURN .T.