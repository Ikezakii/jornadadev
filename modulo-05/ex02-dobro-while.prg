FUNCTION Main()

    LOCAL nNum
    LOCAL cNum
    LOCAL nStop

    DO WHILE .T.

        ACCEPT "Digite o valor inicial: " TO cNum
        IF validar_num(cNum) // , .F., .F., .F., NIL, 0
            nNum := Val(cNum)
            EXIT
        ELSE
            QOut("O valor deve ser um número válido")
        ENDIF

    END DO

    DO WHILE .T.

        QOut(alltrim(str((nNum + nNum))))

        DO WHILE .T.

            ACCEPT "Insira um novo valor ou digite 0 ou um numero negativo para encerrar: " TO cNum
            IF validar_num(cNum) // , .F., .F., .F., NIL, 0
                nNum := Val(cNum)
                EXIT
            ELSE
                QOut("O valor deve ser um número válido")
            ENDIF
        END DO

        IF nNum <= 0
            EXIT
        ENDIF

    END DO


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