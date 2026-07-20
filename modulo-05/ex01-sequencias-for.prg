FUNCTION Main()

    LOCAL contador


    QOut("Imprima os números de 1 a 100")
    FOR contador := 1 TO 100
        QOut(contador)
    NEXT

    QOut("Imprima os números de -50 a 50")
    FOR contador := -50 TO 50
        QOut(contador)
    NEXT

    QOut("Imprima os números de 80 a 5")
    FOR contador := 80 TO 5 STEP -1
        QOut(contador)
    NEXT


RETURN NIL



/*Usando FOR/NEXT , escreva um programa que: - a) Imprima os números de 1 a 100 - b)
Imprima os números de -50 a 50 - c) Imprima os números de 80 a 5 em ordem decrescente
(use STEP -1 )*/