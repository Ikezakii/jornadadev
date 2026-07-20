FUNCTION Main()

    LOCAL cEscolha
    LOCAL nResultado 
    LOCAL nNum1
    LOCAL nNum2



    INPUT "Digite um número: " TO nNum1


    ACCEPT "Escolha a operação (+ , - , * , ^ , R)" TO cEscolha

    DO CASE 

        CASE alltrim(cEscolha) == "+"

            Input "Digite o segundo número: " TO nNum2
            nResultado := nNum1 + nNum2

        CASE alltrim(cEscolha) == "-"

            Input "Digite o segundo número: " TO nNum2
            nResultado := nNum1 - nNum2

        CASE alltrim(cEscolha) == "*"

            Input "Digite o segundo número: " TO nNum2
            nResultado := nNum1 * nNum2

        CASE alltrim(cEscolha) == "/"

            Input "Digite o segundo número: " TO nNum2
            IF nNum2 == 0
                QOut("Erro: divisão por zero!")
                RETURN NIL
            ENDIF
            nResultado := nNum1 / nNum2


        CASE alltrim(cEscolha) == "^"

            Input "Digite o segundo número: " TO nNum2
            nResultado := nNum1 ^ nNum2
        
        CASE alltrim(UPPER(cEscolha)) == "R"

            nResultado := Sqrt(nNum1)
            
        OTHERWISE

            QOut("Opção inválida")

    END CASE

    QOut(alltrim(str(nResultado)))



RETURN NIL

/*Avocê precisa de um acumulador ( nTotal )  --> usar isso pra ele continuar digitando 

nResultado := novonum ?*/