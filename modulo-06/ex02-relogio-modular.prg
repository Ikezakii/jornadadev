FUNCTION Main()
    LOCAL nInicio := Seconds()

    DO WHILE Seconds() - nInicio < 10
        exibir_hora()
        HB_IdleSleep(2)
    END DO


RETURN NIL //Meio que não precisou formatar a data...? ela já veio no formato solicitado...


FUNCTION obterhora()

    LOCAL hora

    hora := Time()

RETURN hora

FUNCTION exibir_hora(cHora)

    LOCAL Hora_atual

    Hora_atual := obterhora()
    QOut(Hora_atual)

RETURN NIL

/*ObterHora() — retorna a hora atual
FormatarHora(cHora) — devolve a string formatada HH:MM:SS
ExibirHora(cHora) — exibe na tela*/