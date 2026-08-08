#include "protheus.ch"

/* =========================================
Rotina de mBrowse para a tabela ZZ1 - Controle de Fornecimento

Permite visualizar, incluir, alterar e excluir registros da ZZ1
além de consultar as ocorrências relacionadas na tabela ZZ2
============================================*/

USER FUNCTION STTZZ1()

    LOCAL oErro
    LOCAL aCores  := {}         
    PRIVATE aRotina := {}    
    PRIVATE cCadastro := "Cadastro de Certificados"

    BEGIN SEQUENCE

        DbSelectArea("ZZ1")
        ZZ1->(DbSetOrder(1))

        // Botão Browse que chama rotina da zz2, usando o codigo da zz1 como filtro
		aRotina := {;
		    {"Pesquisar", "AxPesqui", 0, 1},;
		    {"Visualizar", "AxVisual", 0, 2},;
		    {"Incluir", "AxInclui", 0, 3},;
		    {"Alterar", "AxAltera", 0, 4},;
		    {"Excluir", "AxDeleta", 0, 5},;
		    {"Ocorrências", "U_STTZZ2FLT", 0, 6};
		}    
					
        /* Legendas
            Vermelho -> certificado vencido
            Amarelo -> certificado vence em até 30 dias
            Verde -> certificado dentro da validade
        */
        aCores := {;
            { "ZZ1_VALCER < dDataBase", "BR_VERMELHO" },;
            { "ZZ1_VALCER <= dDataBase + 30", "BR_AMARELO" },;
            { "ZZ1_VALCER > dDataBase + 30", "BR_VERDE" };
        }

        // Browse principal
        mBrowse(6,1,22,75,"ZZ1")

    RECOVER USING oErro
        // Grava um log de eventual erro
        U_GravarLogTCC("STTZZ1",oErro)

        MsgStop("Erro ao abrir cadastro de certificados")

    END SEQUENCE

RETURN NIL