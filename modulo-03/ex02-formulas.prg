#define PI 3.14159

FUNCTION Main()

    area_circulo()
    imc()
    hipotenusa()
    // Poderia passar os valores como parametros para as funções tbm, alterando uma coisa ou outra
RETURN NIL

FUNCTION area_circulo()

    LOCAL cRaio
    
    ACCEPT "Digite o Raio: " TO cRaio

    QOut("Área do círculo: " + alltrim(str(PI * (Val(cRaio)^2),10,2)))

RETURN NIL

FUNCTION imc()

    LOCAL nPeso
    LOCAL nAltura

    INPUT "Digite seu peso: " TO nPeso
    INPUT "Digite sua altura: " TO nAltura

    QOut("Seu IMC é: " + alltrim(str(nPeso / (nAltura^2),10,2)))

RETURN NIL

FUNCTION hipotenusa()

    LOCAL nCatetoa
    LOCAL nCatetob

    INPUT "Digite o valor de um cateto: " TO nCatetoa
    INPUT "Digite o valor do outro cateto: " TO nCatetob

    QOut("O valor da hipotenusa é: " + alltrim(str(sqrt((nCatetoa^2) + (nCatetob^2)),10,2)))

RETURN NIL

// Usei INPUT e ACCEPT para experimentar as duas formas, uma convertendo o tipo da variavel e outro fazendo direto
// E aproveitando e usando "funções personalizadas"