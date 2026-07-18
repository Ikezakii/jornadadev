FUNCTION validar_ano()
    LOCAL cAno

    DO WHILE .T.

        ACCEPT "Ano: " TO cAno

        IF validar_num_int(cAno, .F. , 4) == .F.

            QOut("Digite um ano válido!")
            LOOP

        ENDIF

        IF len(cAno) != 4 .OR. Val(cAno) > YEAR(DATE())  

            QOut("Digite um ano válido!")
        ELSE
            EXIT
        ENDIF
    END DO

RETURN cAno
