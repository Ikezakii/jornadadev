FUNCTION Main()

    LOCAL aArray := {}
    LOCAL nCont
    LOCAL index
    LOCAL cNum
    LOCAL nNum
    LOCAL nTot := 0
    LOCAL nMedia := 0

    FOR nCont := 1 TO 10

        DO WHILE .T.

            ACCEPT "Digite um número: " TO cNum
            IF validar_num(cNum, .F., .T., .T.)
                nNum := Val(cNum)
                AADD(aArray, nNum)
                EXIT
            ELSE
                QOut("Digite um numero válido")
            ENDIF
        END DO

    NEXT    
    QOut("")

    ASORT(aArray)
    FOR EACH index in aArray
        QQOut(alltrim(str(index,10,2)) + "  ")
        nTot += index
    END FOR
    nMedia := nTot / len(aArray)

    QOut("A soma de todos os valores é " + alltrim(str(nTot)))
    QOut("A média dos valores é " + alltrim(str(nMedia)))
    QOut("O maior valor é " + alltrim(str(aArray[len(aArray)])))
    QOut("O menor valor é " + alltrim(str(aArray[1])))

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