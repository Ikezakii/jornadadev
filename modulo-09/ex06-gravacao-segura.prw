USER FUNCTION STTIP003SALVAR()

    LOCAL lOk := .T.
    LOCAL oErro

    BeginTran() 

    BEGIN SEQUENCE

        IF Empty(M->Z1_CLIENTE)
            MsgAlert("Cliente é obrigatório!", "Atenção")
            lOk := .F.
            Break() 
        ENDIF

        dbSelectArea("SZ1")
        IF INCLUI
            RecLock("SZ1", .T.) 
        ELSE
            RecLock("SZ1", .F.)
        ENDIF

        SZ1->Z1_CODIGO := M->Z1_CODIGO
        SZ1->Z1_CLIENTE := M->Z1_CLIENTE
        SZ1->Z1_ASSUNTO := M->Z1_ASSUNTO
        MsUnLock() 

    RECOVER WITH oErro
    
        lOk := .F.
        RollBackTran()
        MsgStop("Erro ao salvar: " + oErro:Description, "Erro")
        U_GRAVARLOG("STTIP003SALVAR", oErro)
        RETURN lOk
        
    END SEQUENCE

    IF lOk
        CommitTran() 
    ENDIF

RETURN lOk


USER FUNCTION GRAVARLOG(cFuncao, oErro)

    LOCAL cArqLog := "\logs\advpl_" + DToS(Date()) + ".log"
    LOCAL nHandle
    LOCAL cLinha

    cLinha := DToS(Date()) + " " + Time() + " | "
    cLinha += cFuncao + " | "
    cLinha += cNomUsr + " | "
    cLinha += "Empresa: " + cEmpAnt + " Filial: " + cFilAnt + " | "

    IF oErro != NIL
        cLinha += "ERRO: " + oErro:Description + " | "
        cLinha += "Func: " + oErro:ProcName + ":" + cValToChar(oErro:ProcLine) + " | "
        cLinha += "SubSist: " + oErro:SubSystem + " | "
        cLinha += "Oper: " + oErro:Operation
    ENDIF

    nHandle := FOpen(cArqLog, FO_READWRITE + FO_SHARED)

    IF nHandle < 0
        nHandle := FCreate(cArqLog)
    ENDIF

    FSeek(nHandle, 0, FS_END) 
    FWrite(nHandle, cLinha + CRLF)
    FClose(nHandle)

RETURN NIL