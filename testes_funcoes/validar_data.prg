FUNCTION validar_data()

    LOCAL dData
    LOCAL cDia
    LOCAL cMes
    LOCAL cAno

    SET DATE FORMAT TO "DD/MM/YYYY"

    cAno := validar_ano()
    cMes := validar_mes()
    cDia := validar_dia(cMes,cAno)

    cMes := StrZero(Val(cMes),2) // se for 1 digito adiciona o 0 na frente (2 -> 02)
    cDia := StrZero(Val(cDia),2)

    dData:= CTOD(cDia + "/" + cMes + "/" + cAno)

RETURN dData