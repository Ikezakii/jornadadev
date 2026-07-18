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
            IF AT(index, "QWERTYUIOPASDFGHJKLÇZXCVBNMÁÉÍÓÚÀÂÃÕÊÔ ") == 0
                RETURN .F.
            ENDIF
        END FOR
    ENDIF

RETURN .T.