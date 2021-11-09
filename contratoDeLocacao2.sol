/* 
SPDX-License-Identifier: MIT
Curso: Programacçaão de Smart Contracts - PUC/SP
Avaliação 2
Requisitos: Constructor, Funções transfer, evento e IF
Contrato de Locação
*/

pragma solidity 0.8.9;

contract contratoDeLocacao {
    
    string public locador;
    string public nacinalidadeLocador;
    string public profissaoLocador;
    uint private cpf;
    string public endereco;
    
    address public locatario = msg.sender;
    string public nacionalidadeLocatario;
    string public profissaoLocatario;
    uint private cpfLocatario;
    string public enderecoLocatario;
    
    string constant public objetoDoContrato = "imovel endereco tal";
    uint public quantidadeDePessoas = 8;
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
        dataDeVencimento = block.timestamp + 30 days * 86400;
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
        payable(locatario).transfer(msg.value);
        valorEmAberto = valorDoAluguel - msg.value;
        emit pagamentoDoAluguel (locatario, msg.value);
        return(valorEmAberto, "Aluguel pendente");
    }
    
    function atualizacaoDoVencimento () public returns(uint){
        require(block.timestamp <= dataDeVencimento);
        dataDeVencimento = block.timestamp + 30 days * 86400;
        return(dataDeVencimento);
    }
    
    function multaAluguelAtrasado(uint _multaAtrasoDeAluguel) public returns (uint) {
        if (dataDeVencimento == block.timestamp + 30 days * 86400)
        multaAtrasoDeAluguel = (valorDoAluguel / prazoDaLocacao) * mesesEmAtraso;
        return(_multaAtrasoDeAluguel);
    }
    
    function multaPessoasEmExcesso(uint _multaPorPessoasExcedentes) public returns (uint, string memory) {
        if(quantidadeDePessoas == 8) quantidadeDePessoas + pessoasExcedentes;
        multaPorPessoasExcedentes = pessoasExcedentes * (valorDoAluguel * 20/100);
        return(_multaPorPessoasExcedentes, "20 por cento por pessoa excedente");
    }
    
    function multaPorDesocupacao(uint _multaDesocupacao) public returns (uint, string memory) {
       multaDesocupacao = valorDoAluguel * 2;
       return(_multaDesocupacao, "multa de dois alugeis");
    }
    
    
}
