FUNCTION Main()

    LOCAL nIdade
    LOCAL cIdade
    LOCAL nCusto_total
    LOCAL nDependentes
    LOCAL nCusto_depen := 90


    DO WHILE .T.
        ACCEPT "Digite sua idade: " TO cIdade
        IF validar_num(cIdade, .F. , .F. , .F. , 100, 1)
            nIdade := Val(cIdade)
            EXIT
        ELSE
            QOut("Digite uma idade válida")
        ENDIF
    END DO

    IF nIdade <= 25

        nCusto_total := 180

    ELSEIF nIdade <=40

        nCusto_total := 260
        
    ELSEIF nIdade <= 60

        nCusto_total := 380

    ELSE

        nCusto_total := 520
    
    ENDIF

    INPUT "Quantos dependentes incluir? " TO nDependentes
    nDependentes := nCusto_depen * nDependentes
    nCusto_total := nCusto_total + nDependentes

    QOut("Custo total: R$" + alltrim(str(nCusto_total)))



RETURN NIL


/*Até 25 anos R$ 180
26 a 40 anos R$ 260
41 a 60 anos R$ 380
Acima de 60 anos R$ 520*/

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