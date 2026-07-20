FUNCTION Main()

    local cMes_nome
    LOCAL cMes
    hb_langSelect("PT")
    SET DATE FORMAT TO "DD/MM/YYYY"//testar se isso funciona so na função teste_while()

    cMes := validar_mes()

    cMes_nome := CMonth(CToD("01/" + alltrim(cMes) + "/2026")) //concatenando o "01/ /2026" pra gerar "uma data"
    QOut(cMes_nome)

RETURN NIL

//Requisito: valide se o número está no intervalo. Fora de 1–12, exiba “Mês inválido”.

FUNCTION validar_mes()

    LOCAL cMes

    DO WHILE .T.

        ACCEPT "Mês: " TO cMes
        
        IF validar_num_int(cMes, .F., 2) == .F.

            QOut("Digite um mês válido!")
            LOOP
        ENDIF

        IF Val(cMes) < 1 .OR. Val(cMes) > 12
            QOut("Digite um mês válido!")
        ELSE
            EXIT
        ENDIF
    END DO
RETURN cMes


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