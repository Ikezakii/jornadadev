FUNCTION Main()

    LOCAL nMaior
    LOCAL nN1 ,nN2
    LOCAL cN1, cN2

    DO WHILE .T.

        ACCEPT "Digite o primeiro número: " TO cN1
        IF validar_num(cN1, .F., .T., .T.)
            nN1 := Val(cN1)
        ELSE
            QOut("Digite apenas números")
            LOOP
        ENDIF

        ACCEPT "Digite o segundo número: " TO cN2
        IF validar_num(cN2, .F., .T., .T.)
            nN2 := Val(cN2)
        ELSE
            QOut("Digite apenas números")
            LOOP
        ENDIF

        EXIT
    END DO

    IF nN1 == nN2
        QOut("Os dois número são iguais")
    ELSE
        IF nN1 > nN2
            QOut(alltrim(str(nN1,10,2)) + " é o maior número")
            QOut(alltrim(str(nN2,10,2)) + " é o menorr número")
        ELSE
            QOut(alltrim(str(nN2,10,2)) + " é o maior número")
            QOut(alltrim(str(nN1,10,2)) + " é o menor número") // testar com IIF() DPS
        ENDIF
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