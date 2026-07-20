FUNCTION Main()

    LOCAL nNum
    LOCAL nDobro
    LOCAL nStop

DO WHILE .T.

    INPUT "Digite o valor inicial: " TO nNum
    IF nNum <= 0
        QOut("O valor inicial deve ser maior que 0")
    ELSE
        EXIT
    ENDIF
END DO

    DO WHILE nNum > 0

        QOut(alltrim(str((nNum + nNum))))

        INPUT "Insira um novo valor ou digite 0 ou um numero negativo para encerrar: " TO nNum


    END DO


RETURN NIL