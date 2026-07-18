FUNCTION validar_num_dec(cNum, lAceita_null , lAceita_negativo) // Considerando que vai vir ja arredondado

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