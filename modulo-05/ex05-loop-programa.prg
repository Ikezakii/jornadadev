FUNCTION Main()

    LOCAL cNome
    LOCAL nNota1
    LOCAL nNota2
    LOCAL cDisci
    LOCAL nMedia
    LOCAL index
    LOCAL cContinuar := "S"

    DO WHILE cContinuar == "S"
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

            INPUT "Digite a primeira nota do aluno: " TO nNota1//Se der usar o novo validador kkkk
            IF nNota1 < 0 .OR. nNota1 > 10
                QOut("Digite uma nota válida")
            ELSE
                EXIT
            ENDIF

        END DO

        DO WHILE .T.
            INPUT "Digite a segunda nota do aluno: " TO nNota2//Se der usar o novo validador kkkk
            IF nNota2 < 0 .OR. nNota2 > 10
                QOut("Digite uma nota válida")
            ELSE
                EXIT
            ENDIF

        END DO
        
        nMedia := (nNota1 + nNota2) / 2

        QOut("Resumo de informações")
        QOut("Nome: " + cNome)
        QOut("Disciplina: " + UPPER(cDisci))
        QOut("Nota 1: " + alltrim(str(nNota1)))
        QOut("Nota 2: " + alltrim(str(nNota2)))
        QOut("Média: " + alltrim(str(nMedia)))

        DO WHILE .T.
            ACCEPT "Deseja continuar? S ou N: " TO cContinuar
            cContinuar := UPPER(alltrim(cContinuar))
            IF Upper(cContinuar) == "S" .OR. Upper(cContinuar) == "N"
                EXIT
            ELSE
                QOut("Digite apenas S ou N.")
            ENDIF
        END DO
    END DO  

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