FUNCTION Main()

    LOCAL nValor
    LOCAL nSoma
    LOCAL nQtd := 0

    INPUT"Digite um valor inicial: " TO nValor

    DO WHILE nSoma != 0
        nQtd++
        INPUT "Digite um valor para ir somando: " TO nSoma

        nValor += nSoma

    END DO

    QOut("A soma de todos os " + alltrim(str(nQtd)) + " valores foi : " + alltrim(str(nValor,10,2)))

RETURN NIL
    

