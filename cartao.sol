pragma solidity 0.8.9;

contract CartaoDeVacinacao {
    // autor: Julio Sapienza
    string constant public nome = "Julio Sapienza";
    string public dose = "primeira";
    string public unidade = "xxxx";
    uint public numeroCNES = 1000;
    uint public data = 7102021;
    uint constant private lote = 12345;
    string constant private fabricante = "astra";
    string public vacinador = "fulano";
    bool public imunizado = false;
    address public wallet = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
}
