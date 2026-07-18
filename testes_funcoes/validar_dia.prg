FUNCTION validar_dia(cMes,cAno)
    LOCAL nDias_max
    LOCAL cDia

    DO WHILE .T.

        ACCEPT "Dia: " TO cDia
        
        IF validar_num_int(cDia, .F., 2) == .F.

            QOut("Digite um dia válido!")
            LOOP
        ENDIF

        nDias_max := dias_no_mes(cMes,cAno)

        IF Val(cDia) < 1 .OR. Val(cDia) > nDias_max
            QOut("Digite um dia válido!")
        ELSE
            EXIT
        ENDIF
    END DO
RETURN cDia