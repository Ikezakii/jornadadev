FUNCTION Main()

    LOCAL nTentativas
    LOCAL nNum := HB_RandomInt(1,100)
    LOCAL cResposta
    LOCAL nResposta


    FOR nTentativas := 1 TO 7

        DO WHILE .T.
            ACCEPT "Faça sua tentativa de 1 a 100: " TO cResposta
            IF validar_num(cResposta, .F., .F., .F., 100, 1)
                nResposta := Val(cResposta)
                EXIT
            ELSE
                QOut("DE 1 a 100 APENAS")
            ENDIF
        END DO


        IF nResposta > nNum
            QOut("Chute um número mais baixo")
        ELSEIF nResposta < nNum
            QOut("Chute um número mais alto")
        ELSE
            EXIT
        ENDIF
            
    END FOR

    IF nResposta == nNum

        QOut("Parabéns o número era " + alltrim(str(nNum)))

    ELSE

        QOut("Não foi dessa vez :( o número era " + alltrim(str(nNum)))

    ENDIF

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
