FUNCTION Main()

    LOCAL nMaior
    LOCAL nN1 ,nN2

    INPUT "Digite o primeiro número: " TO nN1
    INPUT "Digite o segundo número: " TO nN2

    IF nN1 == nN2
        QOut("Os dois número são iguais")
    ELSE
        IF nN1 > nN2
            QOut(alltrim(str(nN1)) + " é o maior número")
            QOut(alltrim(str(nN2)) + " é o menorr número")
        ELSE
            QOut(alltrim(str(nN2)) + " é o maior número")
            QOut(alltrim(str(nN1)) + " é o menor número") // testar com IIF() DPS
        ENDIF
    ENDIF
RETURN NIL
