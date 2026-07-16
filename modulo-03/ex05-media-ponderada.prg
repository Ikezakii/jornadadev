FUNCTION Main()

    LOCAL nNota1
    LOCAL nNota2
    LOCAL nNota3
    LOCAL nNota4
    LOCAL nMedia

    INPUT "Digite a primeira nota do aluno: " TO nNota1
    INPUT "Digite a segunda nota do aluno: " TO nNota2
    INPUT "Digite a terceira nota do aluno: " TO nNota3
    INPUT "Digite a quarta nota do aluno: " TO nNota4

    nMedia := ((nNota1*1) + (nNota2*2) + (nNota3*3) + (nNota4*4)) / (1+2+3+4)

    QOut("A média do aluno é: " + alltrim(str(nMedia,10,2)))

RETURN NIL