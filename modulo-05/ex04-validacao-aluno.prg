FUNCTION Main()

    LOCAL cNome
    LOCAL cNota1
    LOCAL cNota2
    LOCAL nNota1
    LOCAL nNota2
    LOCAL cDisci
    LOCAL nMedia

    DO WHILE .T.

        ACCEPT "Qual nome do Aluno? " TO cNome//Usar validar_texto?
        IF validar_texto(cNome)
            EXIT
        ELSE
            QOut("Digite um nome válido")
        ENDIF

    END DO

    DO WHILE .T.
        ACCEPT "Qual disciplina avaliada? " TO cDisci //Usar validar_texto?


        IF len(alltrim(cDisci)) != 3 .OR. cDisci != UPPER(alltrim(cDisci))
            QOut("Digite a matéria no formato de 3 digitos! - EX: MAT")
            LOOP
        ENDIF

        IF validar_texto(cDisci)
            EXIT
        ELSE
            QOut("Digite a matéria no formato de 3 digitos! - EX: MAT")
        ENDIF

    END DO

    DO WHILE .T.

        ACCEPT "Digite a primeira nota do aluno: " TO cNota1//Se der usar o novo validador kkkk
        IF validar_num(cNota1, .F., .F., .T., 10, 0)
            nNota1 := Val(cNota1)
            EXIT
        ELSE
            QOut("Digite uma nota válida de 0 a 10")
        ENDIF

    END DO

    DO WHILE .T.

        ACCEPT "Digite a primeira nota do aluno: " TO cNota2//Se der usar o novo validador kkkk
        IF validar_num(cNota2, .F., .F., .T., 10, 0)
            nNota2 := Val(cNota2)
            EXIT
        ELSE
            QOut("Digite uma nota válida de 0 a 10")
        ENDIF

    END DO
    
    nMedia := (nNota1 + nNota2) / 2

    QOut("Resumo de informações")
    QOut("Nome: " + cNome)
    QOut("Disciplina: " + UPPER(cDisci))
    QOut("Nota 1: " + alltrim(str(nNota1)))
    QOut("Nota 2: " + alltrim(str(nNota2)))
    QOut("Média: " + alltrim(str(nMedia)))


RETURN NIL



/*Leia nome, disciplina e 2 notas de um aluno, validando cada campo com um loop de
consistência (só avança quando o valor for válido): - Nome: não pode ser vazio - Disciplina:
exatamente 3 letras maiúsculas (ex.: MAT , POR ) - Notas: cada uma entre 0 e 10
Ao final, exiba os dados e a média das duas notas.
Dica: Len(Trim(cNome)) > 0 verifica não-vazio; Len(cDisc) == 3 .AND. cDisc ==
Upper(cDisc) ajuda na disciplina.*/


FUNCTION validar_texto(cTexto,nLimite,lAceita_null,lAceita_num_especial)

    LOCAL index

    IF lAceita_null == NIL
        lAceita_null := .F.
    ENDIF

    IF lAceita_num_especial == NIL
        lAceita_num_especial := .F.
    ENDIF

    IF nLimite == NIL
        nLimite := 30
    ENDIF

    IF nLimite < 1
        nLimite := 1
    ENDIF


    IF lAceita_null == .F.
        IF EMPTY(alltrim(cTexto))
            RETURN .F.
        ENDIF
    ENDIF

    IF len(alltrim(cTexto)) > nLimite
        RETURN .F.
    ENDIF

    IF lAceita_num_especial == .F.
        FOR EACH index IN UPPER(alltrim(cTexto))
            IF AT(index, "QWERTYUIOPASDFGHJKLÇZXCVBNMÁÉÍÓÚÀÂÃÕÊÔ ") == 0
                RETURN .F.
            ENDIF
        END FOR
    ENDIF

RETURN .T.


FUNCTION validar_num(cNum, lAceita_null , lAceita_negativo, lAceita_dec,nLimite_val, nMin_val)
    LOCAL index
    LOCAL lPonto := .F.
    LOCAL nPos := 0
    LOCAL lTem_num := .F.
    LOCAL nValor

    cNum := AllTrim(cNum)

    IF lAceita_null == NIL
        lAceita_null := .F.
    ENDIF

    IF lAceita_dec == NIL
        lAceita_dec := .F.
    ENDIF

    IF lAceita_negativo == NIL
        lAceita_negativo := .F.
    ENDIF

    IF lAceita_null == .F.
        IF EMPTY(cNum)
            RETURN .F.
        ENDIF
    ENDIF


    FOR EACH index IN cNum
        nPos++
        IF index == "-"
            IF lAceita_negativo == .T. .AND. nPos == 1
                LOOP
            ELSE
                RETURN .F.
            ENDIF
        ENDIF

        IF index == "."
            IF lAceita_dec .AND. !lPonto
                lPonto := .T.
                LOOP
            ELSE
                RETURN .F.
            ENDIF
        ENDIF

        IF AT(index,"0123456789") > 0
            lTem_num := .T.
            LOOP
        ENDIF

    END FOR

    IF lTem_num == .F.
        RETURN .F.
    ENDIF

    nValor := Val(cNum)

    IF nMin_val != NIL
        IF nValor < nMin_val
            RETURN .F.
        ENDIF
    ENDIF

    IF nLimite_val != NIL
        IF nValor > nLimite_val
            RETURN .F.
        ENDIF
    ENDIF

RETURN .T.