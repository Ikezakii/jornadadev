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
