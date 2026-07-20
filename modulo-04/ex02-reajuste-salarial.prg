FUNCTION Main()

    LOCAL nSalario
    LOCAL nReajuste
    LOCAL nNovo_sal

    INPUT "Digite o salário: " TO nSalario

    IF nSalario < 1.000

        nNovo_sal := nSalario * 0.85

    ELSEIF nSalario <= 2.000

        nNovo_sal := nSalario * 0.88

    ELSEIF nSalario <= 4.000

        nNovo_sal := nSalario * 0.92

    ELSE

        nNovo_sal := nSalario * 0.95

    ENDIF

    QOut("Novo salário: " + alltrim(str(nNovo_sal,10,2)))

RETURN NIL

/*< R$ 1.000 15%
R$ 1.000 a R$ 2.000 12%
R$ 2.000 a R$ 4.000 8%
> R$ 4.000 5%*/