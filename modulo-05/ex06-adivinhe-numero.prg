FUNCTION Main()

    LOCAL nTentativas
    LOCAL nNum := HB_RandomInt(1,100)
    LOCAL nResposta


    FOR nTentativas := 1 TO 7

        DO WHILE .T.
            INPUT "Faça sua tentativa de 1 a 100: " TO nResposta
            IF nResposta < 1 .OR. nResposta > 100
                QOut("DE 1 a 100 APENAS")
            ELSE
                EXIT
            ENDIF
        END DO

        IF nResposta > nNum
            QOut("Chute um número mais baixo")
        ELSEIF nResposta < nNum
            QOut("Chute um número mais alto")
        ELSE
            EXIT
        ENDIF
            
    END FOR

    IF nResposta == nNum

        QOut("Parabéns o número era " + alltrim(str(nNum)))

    ELSE

        QOut("Não foi dessa vez :( o número era " + alltrim(str(nNum)))

    ENDIF

RETURN NIL
