#include "protheus.ch"

USER FUNCTION STTIP001()
   PRIVATE cCadastro := "Pets"
   dbSelectArea("ZA1")
   dbSetOrder(1)
   //AxCadastro("ZA1", "Pets", , "1", , , , .F.) 
   AxCadastro("ZA1", "Pets")
RETURN NIL 

// Evidencia dos pets na pasta "evidencias_ex03"