FUNCTION Main()
    LOCAL aluno
    LOCAL nQtd_alunos
    LOCAL cQtd_alunos
    LOCAL cNome_aluno
    LOCAL nCont 
    LOCAL cNota
    LOCAL nNota
    LOCAL nCont_nota
    LOCAL aAll_alunos := {}
    LOCAL nMedia


    DO WHILE .T.
        ACCEPT "Quantos alunos serão avaliados? " TO cQtd_alunos
        IF validar_num(cQtd_alunos, .F., .F., .F., NIL, 1)
            nQtd_alunos := Val(cQtd_alunos)
            EXIT
        ELSE
            QOut("Digite uma quantidade válida")
        ENDIF
    END DO

    FOR nCont := 1 TO nQtd_alunos
        QOut(Replicate("=",35))
        DO WHILE .T.
            ACCEPT "Digite o nome do aluno: " TO cNome_aluno
            IF validar_texto(cNome_aluno)
                AADD(aAll_alunos,{})
                AADD(aAll_alunos[nCont],cNome_aluno)
                EXIT
            ELSE
                QOut("Digite um nome válido")
            ENDIF
        END DO

        FOR nCont_nota := 1 TO 4
            DO WHILE .T.
                ACCEPT "Digite a nota do aluno: " TO cNota
                IF validar_num(cNota, .F., .F., .T., 10, 0)
                    nNota := Val(cNota)
                    //AADD(aNotas,nNota)
                    AADD(aAll_alunos[nCont],nNota)
                    EXIT
                ELSE
                    QOut("Digite uma nota válida")
                ENDIF
            END DO
        NEXT

    //AADD(aAll_alunos, {cNome_aluno,aNotas[1],aNotas[2],aNotas[3],aNotas[4]}) // posso usar o index do primeiro for?

    NEXT
    QOut(Replicate("=",35))
    FOR EACH aluno in aAll_alunos //{cNome_aluno,aNotas[1],aNotas[2],aNotas[3],aNotas[4]}

        nMedia := (aluno[2] + aluno[3] + aluno[4] + aluno[5]) / 4
        IF nMedia >= 7
            QOut(aluno[1] + " -- " + alltrim(str(nMedia,10,2) + " -> Aprovado"))
        ELSE
            Qout(aluno[1] + " -- " + alltrim(str(nMedia,10,2) + " -> Reprovado"))

        ENDIF

    END FOR
    
RETURN NIL



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