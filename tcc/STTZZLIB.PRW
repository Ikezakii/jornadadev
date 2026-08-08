#include "protheus.ch"

/* =========================================
Biblioteca de funções auxiliares do projeto de Controle de Fornecimento.
============================================*/

//Busca o nome do fornecedor na SA2
USER FUNCTION NomeFornecedor(cFornec, cLoja)

    LOCAL cNome := ""
    LOCAL oErro

    BEGIN SEQUENCE
        IF !Empty(cFornec)
            cNome := POSICIONE("SA2",1,xFilial("SA2") + cFornec + cLoja,"A2_NOME")
        ENDIF

    RECOVER USING oErro

        U_GravarLogTCC("NomeFornecedor", oErro)

    END SEQUENCE

RETURN cNome


// Busca descrição do produto na SB1
USER FUNCTION NomeProduto(cCodPro)

    LOCAL cDesc := ""
    LOCAL oErro


    BEGIN SEQUENCE

        IF !Empty(cCodPro)
            cDesc := POSICIONE("SB1",1,xFilial("SB1") + cCodPro,"B1_DESC")
        ENDIF

    RECOVER USING oErro

        U_GravarLogTCC("NomeProduto", oErro)

    END SEQUENCE


RETURN cDesc


// Calcula percentual de não conformidade
USER FUNCTION PercNaoConforme(nOk,nNok)

    LOCAL nPerc := 0
    LOCAL oErro

    BEGIN SEQUENCE

        IF (nOk+nNok) > 0

            nPerc := (nNok / (nOk+nNok)) * 100

        ENDIF

    RECOVER USING oErro

        U_GravarLogTCC("PercNaoConforme", oErro)

    END SEQUENCE

RETURN nPerc


//VerIFica se certIFicado vence em até 30 dias
USER FUNCTION CertificadoVencendo(dValCer)

    LOCAL lRet := .F.
    LOCAL oErro

    BEGIN SEQUENCE

        IF !Empty(dValcer)
            IF dValCer <= (dDataBase + 30) .AND. dValCer >= dDataBase

                lRet := .T.

            ENDIF
        ENDIF
    RECOVER USING oErro

        U_GravarLogTCC("CertIFicadoVencendo", oErro)

    END SEQUENCE

RETURN lRet


// Grava log de erros
USER FUNCTION GravarLogTCC(cFuncao,oErro)

    LOCAL cMensagem := ""

    BEGIN SEQUENCE

        IF ValType(oErro) == "O"

            cMensagem := oErro:Description

        Else

            cMensagem := cValToChar(oErro)

        ENDIF

        ConOut("==========================")
        ConOut("FUNÇÃO: " + cFuncao)
        ConOut("ERRO: " + cMensagem)
        ConOut("DATA: " + DToC(Date()))
        ConOut("==========================")

    RECOVER

        ConOut("Falha ao gravar log")

    END SEQUENCE

RETURN NIL


USER FUNCTION ToleranciaZZ1(cCodigo)

    LOCAL nTolera := 0
    LOCAL oErro

    BEGIN SEQUENCE

        nTolera := POSICIONE("ZZ1",1,xFilial("ZZ1")+cCodigo,"ZZ1_TOLERA")

    RECOVER USING oErro

        U_GravarLogTCC("ToleranciaZZ1",oErro)

    END SEQUENCE

RETURN nTolera


// Valida dados do cadastro ZZ1
USER FUNCTION ValidaZZ1()

    LOCAL lRet := .T.
    LOCAL cMsg := ""
    LOCAL oErro

    BEGIN SEQUENCE

        // Valida fornecedor

        IF Empty(M->ZZ1_FORNEC)

            cMsg := "Informe o fornecedor."
            lRet := .F.

        ELSEIF !ExistCpo("SA2", xFilial("SA2") + M->ZZ1_FORNEC + M->ZZ1_LOJAFO, 1)

            cMsg := "Fornecedor não encontrado."
            lRet := .F.

        ENDIF


        // Valida tolerância

        IF lRet .AND. (M->ZZ1_TOLERA < 0 .OR. M->ZZ1_TOLERA > 100)

            cMsg := "A tolerância deve estar entre 0 e 100."
            lRet := .F.

        ENDIF

        // Valida certificado

        IF lRet .AND. INCLUI .AND. M->ZZ1_VALCER < dDataBase

            cMsg := "A validade do certificado não pode ser inferior à data atual."
            lRet := .F.

        ENDIF

        IF !lRet
            MsgStop(cMsg)
        ENDIF

    RECOVER USING oErro

        U_GravarLogTCC("ValidaZZ1", oErro)

        MsgStop("Erro ao validar cadastro ZZ1.")

        lRet := .F.

    END SEQUENCE

RETURN lRet


USER FUNCTION ValidaZZ2()

    LOCAL lRet := .T.
    LOCAL cMsg := ""
    LOCAL oErro

    BEGIN SEQUENCE

        // Valida controle da ZZ1

        IF Empty(M->ZZ2_CONFOR)

            cMsg := "Informe o controle da ZZ1."
            lRet := .F.

        ELSEIF !ExistCpo("ZZ1",  xFilial("ZZ1") + M->ZZ2_CONFOR, 1)

            cMsg := "Controle informado não existe na ZZ1."
            lRet := .F.

        ENDIF

        // Valida produto na SB1

        IF lRet .AND. Empty(M->ZZ2_CODPRO)

            cMsg := "Informe o produto."
            lRet := .F.

        ELSEIF lRet .AND. !ExistCpo("SB1", xFilial("SB1") + M->ZZ2_CODPRO, 1)

            cMsg := "Produto não encontrado na SB1."
            lRet := .F.

        ENDIF

        // Valida data da ocorrência

        IF lRet .AND. M->ZZ2_DATA > dDataBase

            cMsg := "A data da ocorrência não pode ser futura."
            lRet := .F.

        ENDIF

        IF !lRet

            MsgStop(cMsg)

        ENDIF

    RECOVER USING oErro

        U_GravarLogTCC("ValidaZZ2", oErro)

        MsgStop("Erro ao validar ocorrência ZZ2.")

        lRet := .F.

    END SEQUENCE

RETURN lRet

USER FUNCTION PodeExcluirZZ1()

    LOCAL lRet := .T.
    LOCAL oErro

    BEGIN SEQUENCE

        IF ExistCpo("ZZ2",xFilial("ZZ2") + ZZ1->ZZ1_COD,1)

            MsgStop("Não é possível excluir este controle. Existem ocorrências vinculadas.")

            lRet := .F.

        ENDIF

    RECOVER USING oErro

        U_GravarLogTCC("PodeExcluirZZ1", oErro)

        MsgStop("Erro ao validar exclusão da ZZ1.")

        lRet := .F.

    END SEQUENCE

RETURN lRet 