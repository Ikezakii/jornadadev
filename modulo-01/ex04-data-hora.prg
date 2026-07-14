FUNCTION Main()

    LOCAL cHora := Time()
    LOCAL dData := Date()
    LOCAL cNome := "Ikezaki"
    LOCAL cCidade := "Guarulhos"
    LOCAL cCurso := "Harbour/ADVPL"
    LOCAL cDivisa := Replicate("=", len("  FICHA DE APRESENTA€ÇO") + 2)
    hb_cdpSelect("PT850") 
    SET DATE FORMAT TO "DD/MM/YYYY"

    QOut((cDivisa))
    QOut("  FICHA DE APRESENTA€ÇO")
    QOut(cDivisa)
    QOut("Nome    : " + cNome)
    QOut("Cidade  : " + cCidade)
    QOut("Curso   : " + cCurso)
    QOut("Data    : " + DToC(dData))
    QOut("Hora    : " + cHora)
    QOut(cDivisa)

RETURN NIL