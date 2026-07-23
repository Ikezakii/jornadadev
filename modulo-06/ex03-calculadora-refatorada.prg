FUNCTION Main()

    LOCAL cEscolha
    LOCAL aResultado 
    LOCAL nNum1
    LOCAL nNum2


    nNum1 := ler_numero()
    nNum2 := ler_numero()
    aResultado := calcular(nNum1,nNum2)

    mostrar_resultado(aResultado)

RETURN NIL
// Função leitura de numero ja na mira, e função calcular com do case dentro, passando a operação como parametro


FUNCTION ler_numero()
    LOCAL cNum
    LOCAL nNum
    DO WHILE .T.
        ACCEPT "Digite um número: " TO cNum
        IF validar_num(cNum, .F., .T., .T.)
            nNum := Val(cNum)
            EXIT
        ELSE
            Qout("Digite um número válido")
        ENDIF
    END DO
RETURN nNum



FUNCTION calcular(nNum1, nNum2)
    LOCAL cEscolha
    LOCAL aResumo := {}
    LOCAL nResultado
    LOCAL cRaiz
    LOCAL nNumalt

    DO WHILE .T.
        ACCEPT "Escolha a operação (+ , - , * , /, ^ , R): " TO cEscolha
        IF len(alltrim(cEscolha)) != 1 .OR. AT(cEscolha,"+  -  *  / ^  R") == 0
            QOut("Escolha apenas essas opções: (+ , - , * , /, ^ , R)")
        ELSE
            EXIT
        ENDIF
    END DO
    AADD(aResumo, nNum1)
    AADD(aResumo, cEscolha)
    AADD(aResumo, nNum2)
    DO CASE 

        CASE alltrim(cEscolha) == "+"
           nResultado := nNum1 + nNum2

        CASE alltrim(cEscolha) == "-"
            nResultado := nNum1 - nNum2

        CASE alltrim(cEscolha) == "*"
            nResultado := nNum1 * nNum2

        CASE alltrim(cEscolha) == "/"
            IF nNum2 == 0
                QOut("Erro: Divisão por zero")
                QUIT
            ELSE 
                nResultado := nNum1 / nNum2
            ENDIF
          
        CASE alltrim(cEscolha) == "^"
            nResultado := nNum1 ^ nNum2

        CASE alltrim(UPPER(cEscolha)) == "R"
            DO WHILE .T.
                ACCEPT ("Deseja saber a raiz de " + alltrim(str(nNum1)) + " ou " + alltrim(str(nNum2)) + ":  ") TO cRaiz // e se os dois forem 9...
                IF cRaiz == alltrim(str(nNum1))
                    nResultado := Sqrt(nNum1)
                    EXIT
                ELSEIF cRaiz == alltrim(str(nNum2))
                    nResultado := Sqrt(nNum2)
                    EXIT
                ELSE
                    QOut("Escolha um dos números")
                ENDIF
            END DO

        OTHERWISE

            QOut("Opção inválida")

    END CASE
    AADD(aResumo, nResultado)

RETURN aResumo

FUNCTION mostrar_resultado(aArray) // Virou gambiarra

    IF aArray[2] == "R"
        IF Sqrt(aArray[1]) == aArray[4]
            QOut("Raiz de " + alltrim(str(aArray[1])) + " = " + alltrim(str(aArray[4])))
        ELSEIF Sqrt(aArray[3]) == aArray[4]
            QOut("Raiz de " + alltrim(str(aArray[3])) + " = " + alltrim(str(aArray[4])))
        ENDIF
    ELSE
        QOut(alltrim(str(aArray[1])) + " " + aArray[2] + " " + alltrim(str(aArray[3]) + " = " + alltrim(str(aArray[4]))))
    ENDIF
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

        IF AT(index,"0123456789") == 0
            RETURN .F.
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