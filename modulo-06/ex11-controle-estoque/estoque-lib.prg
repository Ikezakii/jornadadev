FUNCTION entrada_estoque(aArray)

    LOCAL cCod
    LOCAL index
    LOCAL cNovo_estq
    LOCAL nNovo_estq
    LOCAL aCod_prods := {}
    LOCAL cString_cods

    IF len(aArray) == 0
        QOut("Sem produtos")
        RETURN NIL
    END IF

    FOR EACH index in aArray
        AADD(aCod_prods, index[1])
    END FOR

    listar_prod(aArray)

    DO WHILE .T.

        ACCEPT "Digite o codigo do produto para alterar: " TO cCod
        IF len(alltrim(cCod)) != 1 
            QOut("Digite um código válido")
            LOOP
        ENDIF

        IF AScan(aCod_prods, {|x| x == Val(cCod)}) == 0
            QOut("Digite um código válido")
            LOOP
        ENDIF

        IF AScan(aCod_prods, {|x| x == Val(cCod)}) >= 1

            DO WHILE .T.
                ACCEPT "Digite o valor do aumento: " TO cNovo_estq
                IF validar_num(cNovo_estq)
                    nNovo_estq := val(cNovo_estq)
                    EXIT
                ELSE
                    QOut("Digite um valor válido")
                ENDIF
            END DO
            EXIT
        END IF
    END DO

    aArray[AScan(aArray, {|x| x[1] == Val(cCod)})][3] += nNovo_estq


RETURN NIL


FUNCTION saida_estoque(aArray)

    LOCAL cCod
    LOCAL index
    LOCAL cNovo_estq
    LOCAL nNovo_estq
    LOCAL aCod_prods := {}
    LOCAL cString_cods
    LOCAL nSub_estoque := 0

    IF len(aArray) == 0
        QOut("Sem produtos")
        RETURN NIL
    END IF

    FOR EACH index in aArray
        AADD(aCod_prods, index[1])
    END FOR

    listar_prod(aArray)

    DO WHILE .T.

        ACCEPT "Digite o codigo do produto para alterar: " TO cCod
        IF len(alltrim(cCod)) != 1 .OR. AScan(aCod_prods, {|x| x == Val(cCod)}) == 0
            QOut("Digite um código válido")
            LOOP
        ENDIF

        DO WHILE .T.
            IF AScan(aCod_prods, {|x| x == Val(cCod)}) >= 1

                DO WHILE .T.
                    ACCEPT "Digite o valor da saída: " TO cNovo_estq
                    IF validar_num(cNovo_estq)
                        nNovo_estq := val(cNovo_estq)
                        IF aArray[AScan(aArray, {|x| x[1] == Val(cCod)})][3] - nNovo_estq < 0 
                            QOut("O estoque não pode ficar negativo")
                            loop
                        END IF
                        EXIT
                    ELSE
                        QOut("Digite um valor válido")
                    ENDIF
                END DO
                
            END IF

            //nSub_estoque := aArray[AScan(aArray, {|x| x[1] == Val(cCod)})][3] - nNovo_estq
            aArray[AScan(aArray, {|x| x[1] == Val(cCod)})][3] -= nNovo_estq
            exit
        END DO
        EXIT
    END DO

RETURN NIL

FUNCTION listar_prod(aArray) // {{codigo, nome, quantidade, preco_unitario}, {codigo, nome, quantidade, preco_unitario}}

    LOCAL index


    IF len(aArray) == 0
        QOut("Sem produtos")
        RETURN NIL
    END IF
    QOut("- - - - -")
    FOR EACH index in aArray

        QOut("Codigo: " + alltrim(str(index[1])) + " - Nome: " + index[2] + " - Quantidade: " + alltrim(str(index[3])) + " - Preço: R$" + alltrim(str(index[4])))
        QOut("- - - - -")

    END FOR


RETURN NIL


FUNCTION Menu()

    LOCAL cOperacao

QOut(replicate("=", len("  CONTROLE DE ESTOQUE SIMPLIFICADO  ")))
QOut("  CONTROLE DE ESTOQUE SIMPLIFICADO")
QOut(replicate("=", len("  CONTROLE DE ESTOQUE SIMPLIFICADO  ")))

QOut("1 - Cadastrar Produtos")
QOut("")
QOut("2 - Listar Produtos")
QOut("")
QOut("3 - Adicionar Estoque") // juntar add e remover?
QOut("")
QOut("4 - Saída de Produtos")
QOut("")
QOut("5 - Buscar Produtos")
QOut("")
QOut("6 - Relatório de Produtos")
QOut("")
QOut("0 - Sair")
QOut(replicate("=", len("  CONTROLE DE ESTOQUE SIMPLIFICADO  ")))


DO WHILE .T.
    ACCEPT "Digite o numero da opção desejada: " TO cOperacao

    IF len(alltrim(cOperacao)) > 1
        QOut("Digite uma operação válida")
        LOOP
    END IF

    IF AT(alltrim(cOperacao), "0123456") > 0 
        EXIT
    ELSE
        QOut("Digite uma operação válida")
        LOOP
    END IF

END DO


RETURN Val(cOperacao)


FUNCTION relatorio(aArray) //{{codigo, nome, quantidade, preco_unitario}, {codigo, nome, quantidade, preco_unitario}}

    LOCAL index
    LOCAL cQtd_preco
    LOCAL cTotal := 0

    IF len(aArray) == 0
        QOut("Sem produtos")
        RETURN NIL
    END IF

    QOut("Resumo de estoque")
    FOR EACH index IN aArray
        cQtd_preco := index[3] * index[4]
        cTotal += cQtd_preco
        QOut(index[2] + " - R$" + alltrim(str(cTotal))) 
    END FOR// produto e preço total em estoque

RETURN NIL

FUNCTION cadastrar_prod(aArray) //{codigo, nome, quantidade, preco_unitario}

    LOCAL aTemp_array := {}
    LOCAL cCod
    LOCAL cNome
    LOCAL cQtd
    LOCAL cPreco

    DO WHILE len(aTemp_array) < 4

        IF len(aArray) == 0 
            cCod := 1
            AADD(aTemp_array,cCod)
        ELSE
            cCod := len(aArray) + 1
            AADD(aTemp_array,cCod)
        ENDIF

        DO WHILE .T.
            ACCEPT "Digite o nome do produto: " TO cNome
            IF len(alltrim(cNome)) == 0 
                QOut("Cadastre um nome válido")
               
            ELSE
                AADD(aTemp_array,cNome)
                EXIT
            ENDIF
        END DO

        DO WHILE .T.
            ACCEPT "Digite o estoque do produto: " TO cQtd
            IF validar_num(cQtd) 
                AADD(aTemp_array, Val(cQtd))
                EXIT
            ELSE
                QOut("Digite um estoque válido")
            ENDIF
        END DO

        DO WHILE .T.
            ACCEPT "Digite o preço do produto: " TO cPreco
            IF validar_num(cQtd,.F.,.F.,.T.) 
                AADD(aTemp_array, Val(cPreco))
                EXIT
            ELSE
                QOut("Digite um preço válido")
            ENDIF
        END DO


    END DO


RETURN aTemp_array

FUNCTION buscar_prod(aArray)

    LOCAL cCod

    IF len(aArray) == 0
        QOut("Sem produtos")
        RETURN 0
    ELSE
        DO WHILE .T.
            ACCEPT "Digite o codigo do produto : " TO cCod
            IF len(alltrim(cCod)) != 1 
                QOut("Digite um código válido")
            ENDIF

            IF AScan(aArray, {|x| x[1] == Val(cCod)}) == 0
                QOut("Código não encontrado")
                EXIT
            else
                EXIT
            ENDIF

        END DO
    END IF

RETURN AScan(aArray, {|x| x[1] == Val(cCod)})

//cadastrar, listar, entrada, saída, buscar,relatório


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
