FUNCTION Main()

    LOCAL cHora := Time()
    LOCAL cData := DToC(Date())
    LOCAL cNome := "Ikezaki"
    LOCAL cCidade := "Guarulhos"
    LOCAL cCurso := "Harbour/ADVPL"
    LOCAL cDivisa := Replicate("=", len("  FICHA DE APRESENTA€ÇO") + 2)
    hb_cdpSelect("PT850") 

    QOut((cDivisa))
    QOut("  FICHA DE APRESENTA€ÇO")
    QOut(cDivisa)
    QOut("Nome    : " + cNome)
    QOut("Cidade  : " + cCidade)
    QOut("Curso   : " + cCurso)
    QOut("Data    : " + cData)
    QOut("Hora    : " + cHora)
    QOut(cDivisa)

RETURN NIL