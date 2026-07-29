
SET PROCEDURE TO estoque-lib.prg

FUNCTION Main()

    LOCAL cOperacao 
    LOCAL aProdutos := {} // len 0
    LOCAL aTemp_array 
    LOCAL nBuscar
    LOCAL index


    DO WHILE cOperacao != 0

        cOperacao := Menu() // consertar funções para parar de executar se nao tiver n\ada no array

        DO CASE //cadastrar, listar, entrada, saída, buscar,relatório

            CASE cOperacao == 1

                aTemp_array := cadastrar_prod(aProdutos)
                AADD(aProdutos, aTemp_array)
                HB_IdleSleep(2)

            CASE cOperacao == 2
                
                listar_prod(aProdutos)
                HB_IdleSleep(5)

            CASE cOperacao == 3

                entrada_estoque(aProdutos)
                HB_IdleSleep(5)

            CASE cOperacao == 4

                saida_estoque(aProdutos)
                HB_IdleSleep(5)
            CASE cOperacao == 5

                nBuscar := buscar_prod(aProdutos)
                IF nBuscar == 0
                    QOut("")
                    HB_IdleSleep(5)
                ELSE
                    QOut("Código: " + AllTrim(Str(aProdutos[nBuscar][1])))
                    QOut("Nome: " + aProdutos[nBuscar][2])
                    QOut("Quantidade: " + AllTrim(Str(aProdutos[nBuscar][3])))
                    QOut("Preço: R$" + AllTrim(Str(aProdutos[nBuscar][4])))
                    HB_IdleSleep(5)

                END IF

            CASE cOperacao == 6

                relatorio(aProdutos)
                HB_IdleSleep(5)

            CASE cOperacao == 0

                QUIT

            OTHERWISE

                QOut("Opção invalida")
        END CASE
    END DO


RETURN NIL


//{codigo, nome, quantidade, preco_unitario}

// entrada de estoque, buscar o nome do produto e aumentar qtd, uso de index lista[x][y]

// o mesmo para saída 

//(menu, cadastrar, listar, entrada, saída, buscar,relatório)