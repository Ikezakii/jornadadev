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