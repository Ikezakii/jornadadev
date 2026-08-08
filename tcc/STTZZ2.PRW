#include "protheus.ch"


/* =========================================
Rotina de mBrowse para a tabela ZZ2 - Ocorrências.

Exibe as ocorrências de fornecimento e utiliza legenda
para indicar registros acima ou dentro da tolerância.
============================================*/

USER FUNCTION STTZZ2()

    LOCAL oErro
    LOCAL aCores := {}
    PRIVATE cCadastro := "Ocorrências do Fornecedor"
    
    BEGIN SEQUENCE

        DbSelectArea("ZZ2")
        ZZ2->(DbSetOrder(1))

        // Legendas
        aCores := {;
            { "U_PercNaoConforme(ZZ2_QTDOK,ZZ2_QTDNOK) > U_ToleranciaZZ1(ZZ2_CONFOR)", "BR_VERMELHO" },;
            { "U_PercNaoConforme(ZZ2_QTDOK,ZZ2_QTDNOK) <= U_ToleranciaZZ1(ZZ2_CONFOR)", "BR_VERDE" };
        }

        // Browse
        mBrowse(1,1,22,75,"ZZ2",,,,,,aCores)

    RECOVER USING oErro

        U_GravarLogTCC("STTZZ2",oErro)

        MsgStop("Erro ao abrir ocorrências")

    END SEQUENCE

RETURN NIL


// Browse filtrado por fornecedor/certificado
USER FUNCTION STTZZ2FLT(cCodigoZZ1)

    LOCAL oErro
    LOCAL aIndexZZ2 := {}
    LOCAL cFiltro := ""        
    PRIVATE cCadastro := "Ocorrências do Fornecedor"

    BEGIN SEQUENCE

        cFiltro := "ZZ2_CONFOR == '" + cCodigoZZ1 + "'"

        FilBrowse("ZZ2",@aIndexZZ2,@cFiltro)

        mBrowse(1,1,22,75,"ZZ2")

        EndFilBrw("ZZ2",aIndexZZ2)

    RECOVER USING oErro

        U_GravarLogTCC("STTZZ2FLT",oErro)

        MsgStop("Erro ao filtrar ocorrências")

    END SEQUENCE

RETURN NIL