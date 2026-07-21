FUNCTION Main()

    LOCAL cEscolha
    LOCAL nResultado 
    LOCAL nNum1
    LOCAL nNum2
    LOCAL cNum1
    LOCAL cNum2


    DO WHILE .T.
        ACCEPT "Digite um número: " TO cNum1
        IF validar_num(cNum1, .F., .T., .T.)
            nNum1 := Val(cNum1)
            EXIT
        ELSE
            Qout("Digite um número válido")
        ENDIF
    END DO

    DO WHILE .T.
        ACCEPT "Escolha a operação (+ , - , * , /, ^ , R): " TO cEscolha
        IF len(cEscolha) != 1 .OR. AT(cEscolha,"+ , - , * , /, ^ , R") == 0
            QOut("Escolha apenas essas opções: (+ , - , * , /, ^ , R)")
        ELSE
            EXIT
        ENDIF
    END DO


    DO CASE 

        CASE alltrim(cEscolha) == "+"
            DO WHILE .T.
                ACCEPT "Digite o segundo número: " TO cNum2
                IF validar_num(cNum2, .F., .T., .T.)
                    nNum2 := Val(cNum2)
                    EXIT
                ELSE
                    Qout("Digite um número válido")
                ENDIF
            END DO

                nResultado := nNum1 + nNum2

        CASE alltrim(cEscolha) == "-"

            DO WHILE .T.
                ACCEPT "Digite o segundo número: " TO cNum2
                IF validar_num(cNum2, .F., .T., .T.)
                    nNum2 := Val(cNum2)
                    EXIT
                ELSE
                    Qout("Digite um número válido")
                ENDIF
            END DO
            nResultado := nNum1 - nNum2

        CASE alltrim(cEscolha) == "*"
            DO WHILE .T.
                ACCEPT "Digite o segundo número: " TO cNum2
                IF validar_num(cNum2, .F., .T., .T.)
                    nNum2 := Val(cNum2)
                    EXIT
                ELSE
                    Qout("Digite um número válido")
                ENDIF
            END DO
            nResultado := nNum1 * nNum2

        CASE alltrim(cEscolha) == "/"
            DO WHILE .T.
                ACCEPT "Digite o segundo número: " TO cNum2
                IF validar_num(cNum2, .F., .T., .T.)
                    nNum2 := Val(cNum2)
                    EXIT
                ELSE
                    Qout("Digite um número válido")
                ENDIF
            END DO
            IF nNum2 == 0
                QOut("Erro: divisão por zero!")
                RETURN NIL
            ENDIF
            nResultado := nNum1 / nNum2


        CASE alltrim(cEscolha) == "^"
            DO WHILE .T.
                ACCEPT "Digite o segundo número: " TO cNum2
                IF validar_num(cNum2, .F., .T., .T.)
                    nNum2 := Val(cNum2)
                    EXIT
                ELSE
                    Qout("Digite um número válido")
                ENDIF
            END DO
            nResultado := nNum1 ^ nNum2
        
        CASE alltrim(UPPER(cEscolha)) == "R"

            nResultado := Sqrt(nNum1)
            
        OTHERWISE

            QOut("Opção inválida")

    END CASE

    QOut(alltrim(str(nResultado)))



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