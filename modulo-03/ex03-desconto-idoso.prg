FUNCTION Main()

    LOCAL cValor
    LOCAL nValor
    LOCAL cNome
    LOCAL cDia
    LOCAL cMes
    LOCAL cAno
    LOCAL dData_nasc
    LOCAL nIdade
    LOCAL nDesconto 
    LOCAL nValor_total
    SET DATE FORMAT TO "DD/MM/YYYY"

    DO WHILE .T.

        ACCEPT "Digite o valor total da compra: R$" TO cValor //vira accept?
        IF validar_num_dec(alltrim(cValor))
            nValor := Val(cValor)
            EXIT
        ELSE
            QOut("Digite um valor v†lido!")
        ENDIF
    END DO

    DO WHILE .T.
        ACCEPT "Digite o nome do cliente: " TO cNome
        IF validar_texto(alltrim(cNome))
            EXIT
        ELSE
            QOut("Digite um nome v†lido!!")
        ENDIF
    END DO

    QOut("Informe sua data de nascimento")
    DO WHILE .T.
        dData_nasc := validar_data()

        nIdade := INT((Date() - dData_nasc) / 365) //Limite de 90+ anos?

        IF nIdade > 99 .OR. nIdade < 1
            QOut("Idade Suspeita. Digite uma data v†lida!")
        ELSE
            EXIT
        ENDIF
    END DO
            
    IF nIdade > 60 //nValor_total := IIF(nIdade > 60, nValor * 0.875, nValor)

        nDesconto := 0.875 // 100 - 12,5
        nValor_total := nValor * nDesconto  

    ELSE

        nValor_total := nValor
        
    ENDIF

    QOut(Replicate("=", 35))
    QOut("        Resumo do Pedido")
    QOut(Replicate("=", 35))
    QOut("Nome do Cliente    : " + alltrim(cNome))
    QOut("Idade              : " + alltrim(str(nIdade)))
    QOut("Valor do Pedido    : R$ " + allTrim(str(nValor,10,2)))
    QOut("Desconto aplicado  : " + IIF(nIdade > 60,"12,5%","N/A"))
    QOut("Valor Total        : R$ " + allTrim(str(nValor_total, 10, 2)))
    QOut(Replicate("=", 35))

RETURN NIL

//Depois que come√ßou a executar comandos, n√£o pode mais declarar LOCAL.


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
            IF AT(index, "QWERTYUIOPASDFGHJKLÄZXCVBNMµê÷‡È∑∂«Â“‚ ") == 0
                RETURN .F.
            ENDIF
        END FOR
    ENDIF

RETURN .T.

FUNCTION validar_data()

    LOCAL dData
    LOCAL cDia
    LOCAL cMes
    LOCAL cAno

    SET DATE FORMAT TO "DD/MM/YYYY"

    cAno := validar_ano()
    cMes := validar_mes()
    cDia := validar_dia(cMes,cAno)
    cMes := StrZero(Val(cMes),2)
    cDia := StrZero(Val(cDia),2)
    dData:= CTOD(cDia + "/" + cMes + "/" + cAno)

RETURN dData


FUNCTION validar_ano()
    LOCAL cAno

    DO WHILE .T.

        ACCEPT "Ano: " TO cAno

        IF validar_num_int(cAno, .F. , 4) == .F.

            QOut("Digite um ano v†lido!")
            LOOP

        ENDIF

        IF len(cAno) != 4 .OR. Val(cAno) > YEAR(DATE())  

            QOut("Digite um ano v†lido!")
        ELSE
            EXIT
        ENDIF
    END DO

RETURN cAno

FUNCTION validar_mes()

    LOCAL cMes

    DO WHILE .T.

        ACCEPT "Màs: " TO cMes
        
        IF validar_num_int(cMes, .F., 2) == .F.

            QOut("Digite um màs v†lido!")
            LOOP
        ENDIF

        IF Val(cMes) < 1 .OR. Val(cMes) > 12
            QOut("Digite um màs v†lido!")
        ELSE
            EXIT
        ENDIF
    END DO
RETURN cMes

FUNCTION validar_dia(cMes,cAno)
    LOCAL nDias_max
    LOCAL cDia

    DO WHILE .T.

        ACCEPT "Dia: " TO cDia
        
        IF validar_num_int(cDia, .F., 2) == .F.

            QOut("Digite um dia v†lido!")
            LOOP
        ENDIF

        nDias_max := dias_no_mes(cMes,cAno)

        IF Val(cDia) < 1 .OR. Val(cDia) > nDias_max
            QOut("Digite um dia v†lido!")
        ELSE
            EXIT
        ENDIF
    END DO
RETURN cDia


FUNCTION dias_no_mes(cMes,cAno) 

    LOCAL nDias

    DO CASE

    CASE Val(cMes) == 2

        IF ano_bis(Val(cAno))
            nDias := 29
        ELSE
            nDias := 28
        ENDIF
    
    CASE Val(cMes) == 4 .OR. Val(cMes) == 6 .OR. Val(cMes) == 9 .OR. Val(cMes) == 11

        nDias := 30
    
    OTHERWISE

        nDias := 31

    END CASE

RETURN nDias



FUNCTION ano_bis(nAno)

    IF nAno % 400 == 0
        RETURN .T.
    ELSEIF nAno % 100 == 0
        RETURN .F.
    ELSEIF nAno % 4 == 0
        RETURN .T.
    ENDIF

RETURN .F.


FUNCTION validar_num_int(cNum, lAceita_null , nLimite , lAceita_negativo)
    LOCAL index
    LOCAL nPos := 0

    IF lAceita_null == NIL
        lAceita_null := .F.
    ENDIF

    IF nLimite == NIL
        nLimite := 1
    ENDIF

    IF lAceita_negativo == NIL
        lAceita_negativo := .F.
    ENDIF

    IF nLimite < 1
        nLimite := 1
    ENDIF

    IF lAceita_null == .F.
        IF EMPTY(alltrim(cNum))
            RETURN .F.
        ENDIF
    ENDIF

    IF Left(alltrim(cNum),1) == "-"
        IF len(alltrim(cNum)) > nLimite + 1
            RETURN .F.
        ENDIF
    ELSE
        IF len(alltrim(cNum)) > nLimite
            RETURN .F.
        ENDIF
    ENDIF

    FOR EACH index IN alltrim(cNum)
        nPos++
        IF index == "-"
            IF lAceita_negativo == .T. .AND. nPos == 1
                LOOP
            ELSE
                RETURN .F.
            ENDIF
        ENDIF

        IF AT(index,"0123456789") == 0
            RETURN .F.
        ENDIF
    END FOR

RETURN .T.

FUNCTION validar_num_dec(cNum, lAceita_null , lAceita_negativo)

    LOCAL index
    LOCAL nPos := 0
    LOCAL lPonto := .F.
    LOCAL lTem_num := .F.

    IF lAceita_null == NIL
        lAceita_null := .F.
    ENDIF

    IF lAceita_negativo == NIL
        lAceita_negativo := .F.
    ENDIF
    IF lAceita_null == .F.
        IF EMPTY(alltrim(cNum))
            RETURN .F.
        ENDIF
    ENDIF

    FOR EACH index IN alltrim(cNum)
        nPos++
        IF index == "-"
            IF lAceita_negativo == .T. .AND. nPos == 1
                LOOP
            ELSE
                RETURN .F.
            ENDIF
        ENDIF

        IF AT(index, "0123456789") > 0 
            lTem_num := .T.
            LOOP
        ENDIF

        IF index == "." .AND. lPonto == .F.
            lPonto := .T.
            LOOP
        ENDIF

        RETURN .F.

    END FOR

    IF lTem_num == .F.
        RETURN .F.
    ENDIF

RETURN .T. 