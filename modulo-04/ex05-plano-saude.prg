FUNCTION Main()

    LOCAL nIdade
    LOCAL nCusto_total
    LOCAL nDependentes

    INPUT "Digite sua idade: " TO nIdade

    IF nIdade <= 25

        nCusto_total := 180

    ELSEIF nIdade <=40

        nCusto_total := 260
        
    ELSEIF nIdade <= 60

        nCusto_total := 380

    ELSE

        nCusto_total := 520
    
    ENDIF

    INPUT "Quantos dependentes incluir? " TO nDependentes

    nCusto_total := nCusto_total + nDependentes

    QOut("Custo total: " + alltrim(str(nCusto_total)))



RETURN NIL


/*Até 25 anos R$ 180
26 a 40 anos R$ 260
41 a 60 anos R$ 380
Acima de 60 anos R$ 520*/