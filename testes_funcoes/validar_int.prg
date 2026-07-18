FUNCTION validar_num_int(cNum, lAceita_null , nLimite , lAceita_negativo)
    LOCAL index
    LOCAL nPos := 0

    IF lAceita_null == NIL
        lAceita_null := .F.
    ENDIF

    IF nLimite == NIL
        lAceita_negativo := 1
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