FUNCTION Main()

    LOCAL cNome := "Ikezaki"
    LOCAL cCidade := "Guarulhos"
    LOCAL cCurso := "Harbour/ADVPL"
    LOCAL cDivisa := Replicate("=", 25) // Dava pra pegar o tamanho do FICHA DE APRESENTACAO
    hb_cdpSelect("PT850") // Deus Aben�oe a comunidade do Discord

    QOut(cDivisa) // Talvez nem seja a maneira mais "eficiente" de fazer
    QOut("  FICHA DE APRESENTA��O")
    QOut(cDivisa)
    QOut("Nome    : " + cNome)
    QOut("Cidade  : " + cCidade)
    QOut("Curso   : " + cCurso)
    QOut(cDivisa)
    
RETURN NIL


