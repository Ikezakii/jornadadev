FUNCTION Main()

    //LOCAL cHora := Time()
    //LOCAL dData := Date()
    LOCAL cNome := "Ikezaki"
    LOCAL cCidade := "Guarulhos"
    LOCAL cCurso := "Harbour/ADVPL"
    //LOCAL cDivisa := Replicate("=", len("  FICHA DE APRESENTA€ÇO") + 2)
    hb_cdpSelect("PT850") 
    SET DATE FORMAT TO "DD/MM/YYYY"

    ?(Replicate("=", len("  FICHA DE APRESENTA€ÇO  ")))
    QOut("  FICHA DE APRESENTA€ÇO")
    ?(Replicate("=", len("  FICHA DE APRESENTA€ÇO") + 2)) // Utilizando "QOut" e "?" para experimenta‡Æo e compara‡Æo de resultados
    QOut("Nome    : " + cNome)
    QOut("Cidade  : " + cCidade)
    QOut("Curso   : " + cCurso)
    QOut("Data    : " + DToC(Date()))
    QOut("Hora    : " + Time())
    ?(Replicate("=", len("  FICHA DE APRESENTA€ÇO") + 2))

RETURN NIL

// Podia nao ter a variavel divisa e tbm nao ter as variaveis de data e hora, vou fazer sem dessa vez