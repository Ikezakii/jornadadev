FUNCTION Main()

    LOCAL nSalario
    LOCAL cSalario
    LOCAL nReajuste
    LOCAL nNovo_sal


    DO WHILE .T.
        ACCEPT "Digite o salário: " TO cSalario
        IF validar_num(cSalario, .F., .F., .T., NIL, 1.500)
            nSalario := Val(cSalario)
            EXIT
        ELSE
            QOut("Digite um salário válido")
        ENDIF
    END DO

    IF nSalario < 1000

        nNovo_sal := nSalario * 1.15

    ELSEIF nSalario <= 2000

        nNovo_sal := nSalario * 1.12

    ELSEIF nSalario <= 4000

        nNovo_sal := nSalario * 1.08

    ELSE

        nNovo_sal := nSalario * 1.05

    ENDIF

    QOut("Novo salário: " + alltrim(str(nNovo_sal,10,2)))

RETURN NIL

/*< R$ 1.000 15%
R$ 1.000 a R$ 2.000 12%
R$ 2.000 a R$ 4.000 8%
> R$ 4.000 5%*/

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