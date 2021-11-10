/* 
SPDX-License-Identifier: MIT
Curso: Programacçaão de Smart Contracts - PUC/SP
Avaliação 2
Requisitos: Constructor, Funções transfer, evento e IF
Contrato de Locação
*/

pragma solidity 0.8.9;

contract contratoDeLocacao {
    
    address public locador = msg.sender;
    string public nacinalidadeLocador;
    string public profissaoLocador;
    uint private cpf;
    string public endereco;
    
    address public locatario;
    string public nacionalidadeLocatario;
    string public profissaoLocatario;
    uint private cpfLocatario;
    string public enderecoLocatario;
    
    string constant public objetoDoContrato = "imovel endereco tal";
    uint public quantidadeDePessoas;
    uint public limiteDePessoas = 8;
    uint public pessoasExcedentes;
    uint public multaPorPessoasExcedentes;
    uint public prazoDaLocacao;
    uint public valorDoAluguel;
    uint public valorEmAberto;
    uint public celebracaoDoContrato;
    uint public dataDeVencimento;
    uint public multaDesocupacao;
    uint public multaAtrasoDeAluguel;
    uint public mesesEmAtraso;
    
    event pagamentoDoAluguel (address _locatario, uint _valorDoAluguel);
    
    constructor(
        uint _valorDoAluguel,
        uint _valorEmAberto,
        uint _quantidadeDePessoas,
        uint _multaPorPessoasExcedentes,
        uint _multaDesocupacao,
        uint _multaAtrasoDeAluguel,
        uint _prazoDaLocacao,
        uint _mesesEmAtraso
        ) 
    {
        locatario = msg.sender;
        valorDoAluguel = _valorDoAluguel;
        valorEmAberto = _valorEmAberto;
        celebracaoDoContrato = block.timestamp;
        dataDeVencimento = block.timestamp + 30 * 86400;
        quantidadeDePessoas = _quantidadeDePessoas;
        multaPorPessoasExcedentes= _multaPorPessoasExcedentes;
        multaDesocupacao = _multaDesocupacao;
        multaAtrasoDeAluguel = _multaAtrasoDeAluguel;
        prazoDaLocacao = _prazoDaLocacao;
        mesesEmAtraso = _mesesEmAtraso;
    }
    
    function pagarAluguel() public payable returns (uint, string memory) {
        require(msg.value == valorDoAluguel);
        require(valorEmAberto == valorDoAluguel, "Aluguel pago.");
        locatario = msg.sender;
        payable(locador).transfer(msg.value);
        valorEmAberto = valorDoAluguel - msg.value;
        atualizacaoDoVencimento();
        emit pagamentoDoAluguel (locatario, msg.value);
        return(valorEmAberto, "Aluguel pago");
    }
    
    function atualizacaoDoVencimento () public returns(uint){
        require(block.timestamp <= dataDeVencimento);
        dataDeVencimento = dataDeVencimento + 30 * 86400;
        return(dataDeVencimento);
    }
    
    function multaAluguelAtrasado() public returns (uint) {
        if (dataDeVencimento < block.timestamp) multaAtrasoDeAluguel = (valorDoAluguel / prazoDaLocacao) * mesesEmAtraso;
        return(multaAtrasoDeAluguel);
    }
    
    function multaPessoasEmExcesso(uint _contagemDePessoas) public returns (uint, string memory) {
        if(_contagemDePessoas > limiteDePessoas) {
            pessoasExcedentes = _contagemDePessoas - limiteDePessoas;
            multaPorPessoasExcedentes = pessoasExcedentes * (valorDoAluguel * 20/100);
            return (multaPorPessoasExcedentes, "multa de 20 por cento");
        }
        return(0, "sem multa");
    }
    
    function multaPorDesocupacao() public returns (uint, string memory) {
       multaDesocupacao = valorDoAluguel * 2;
       return(multaDesocupacao, "multa de dois alugeis");
    }
