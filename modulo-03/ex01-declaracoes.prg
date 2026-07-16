FUNCTION Main()

    LOCAL cNome_funcionario := "Ikezaki"
    LOCAL nSalario := 2000
    LOCAL lAtivo := .T.
    LOCAL dAdmissao := CToD("01/04/2024")
    LOCAL nCod_departamento := 1
 
    QOut("Tipo de dado: " + Valtype(cNome_funcionario))
    QOut("Tipo de dado: " + Valtype(nSalario))
    QOut("Tipo de dado: " + Valtype(lAtivo))
    QOut("Tipo de dado: " + Valtype(dAdmissao))
    QOut("Tipo de dado: " + Valtype(nCod_departamento))

RETURN NIL