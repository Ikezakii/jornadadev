FUNCTION FatorialN(nN)

    LOCAL nCont
    LOCAL nFat := 1

    FOR nCont := 1 TO nN
        nFat *= nCont
    ENDFOR

RETURN nFat




FUNCTION EhPrimo(nN)

    LOCAL nCont 

    IF nN < 2
        RETURN .F.
    ENDIF

    FOR nCont := 2 TO nN - 1
        IF nN % nCont == 0
            RETURN .F.
        ENDIF
    END FOR

RETURN .T.




FUNCTION MMC(nA, nB)

    LOCAL nMmc

    nMmc:= (nA * nB) / MDC(nA,nB)

RETURN nMmc




FUNCTION MDC(nA, nB)

    LOCAL nMenor
    LOCAL nCont

    IF nA == 0 .OR. nB == 0
        RETURN 0
    ENDIF

    IF nA < nB
        nMenor := nA
    ELSEIF nB < nA
        nMenor := nB
    ENDIF

    FOR nCont := nMenor TO 1 STEP -1
        IF nA % nCont == 0 .AND. nB % nCont == 0
            RETURN nCont
        ENDIF
    NEXT

RETURN NIL