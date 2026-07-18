FUNCTION ano_bis(nAno)

    IF nAno % 400 == 0
        RETURN .T.
    ELSEIF nAno % 100 == 0
        RETURN .F.
    ELSEIF nAno % 4 == 0
        RETURN .T.
    ENDIF

RETURN .F.