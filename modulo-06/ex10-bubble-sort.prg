FUNCTION Main()

    LOCAL aArray := {}
    LOCAL aNovo_array := {}
    LOCAL cont
    

    FOR cont := 1 TO 10
        AADD(aArray,HB_RandomInt(10,70))
    NEXT

    BubbleSort(aArray)

RETURN NIL



FUNCTION BubbleSort(aVetor)

    LOCAL nTemp
    LOCAL nIndex 
    LOCAL nComp
    LOCAL nMenor
    LOCAL val

    FOR nComp:= 1 TO len(aVetor) - 1
        FOR nIndex:= 1 TO len(aVetor) - nComp 
            IF aVetor[nIndex] > aVetor[nIndex + 1] // vetor[1] > vetor [2] // vetor[2] > vetor[3] // vetor[]
                nTemp := aVetor[nIndex + 1] 
                aVetor[nIndex + 1] := aVetor[nIndex] 
                aVetor[nIndex] := nTemp
            ENDIF
        END FOR
    END FOR


    FOR EACH val in aVetor
        QOut(val)
    END FOR

RETURN NIL


// comparar os pares adjacentes? como
// array[index] := X
// como eu comparo na vida real, pego um numero e comparo ele com os outros, se eu acho um maior que ele eu uso ele e vou comparando ate o final e repetindo??
// dois loops? um pra percorrer cada elemento e outro pra percorrer e comparar?
// 6 10 7 4 18 90 12