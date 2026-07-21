FUNCTION Main()

    LOCAL nValor
    LOCAL cValor
    LOCAL cSoma
    LOCAL nSoma
    LOCAL nQtd := 0

    DO WHILE .T.
        ACCEPT "Digite um valor inicial: " TO cValor
        IF validar_num(cValor, .F., .T., .T.)
            nValor := Val(cValor)
            EXIT
        ELSE
            QOut("Digite um número válido")
        ENDIF
    END DO

    DO WHILE nSoma != 0
        nQtd++
        DO WHILE .T.
            ACCEPT "Digite um valor para ir somando: " TO cSoma
            IF validar_num(cSoma, .F., .T., .T.)
                nSoma := Val(cSoma)
                EXIT
            ELSE
                QOut("Digite um número válido")
            ENDIF
        END DO
        
        nValor += nSoma

    END DO

    QOut("A soma de todos os " + alltrim(str(nQtd)) + " valores foi : " + alltrim(str(nValor,10,2)))

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