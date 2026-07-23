FUNCTION MAIN() // tem que ter o loop de recomeçar
    LOCAL cJogada
    LOCAL cJogadacpu
    LOCAL cVencedor

    DO WHILE .T.
        ACCEPT "EScolha sua jogada (Pedra, papel ou tesoura): " TO cJogada
        IF validar_jogada(alltrim(lower(cJogada)))
            EXIT
        ELSE
            QOut("Digite uma jogada válida")
        ENDIF   
    END DO

    cJogadacpu := sortear_jogada_cpu()
    definir_ganhador(cJogada,cJogadacpu)

RETURN NIL



FUNCTION sortear_jogada_cpu() 

    LOCAL aOpcoes := {"pedra", "papel", "tesoura"}
    LOCAL cJogada

    cJogada := aOpcoes[HB_RandomInt(1,len(aOpcoes))]

RETURN cJogada


FUNCTION validar_jogada(cJogada)

    IF AT(alltrim(lower(cJogada)),"pedra papel tesoura") > 0
        RETURN .T.
    ELSE
        RETURN .F.
    ENDIF

RETURN NIL


FUNCTION definir_ganhador(cJogada1,cJogada2)

    QOut("Jogador: " + cJogada1)
    QOut("CPU: " + cJogada2)

    IF cJogada1 == "pedra"
        IF cJogada2 == "papel"
            QOut("CPU ganhou")
        ELSEIF cJogada2 == "tesoura"
            QOut("Jogador ganhou")
        ELSE
            QOut("Empate")
        ENDIF
    ELSEIF cJogada1 == "papel"
        IF cJogada2 == "pedra"
            QOut("Jogador ganhou")
        ELSEIF cJogada2 == "tesoura"
            QOut("CPU ganhou")
        ELSE
            QOut("Empate")
        ENDIF
    ELSE // tesoura
        IF cJogada2 == "pedra"
            QOut("CPU ganhou")
        ELSEIF cJogada2 == "papel"
            QOut("Jogador ganhou")
        ELSE
            QOut("Empate")
        ENDIF
    ENDIF
RETURN NIL



