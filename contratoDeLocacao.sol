/* 
Curso: Programacçaão de Smart Contracts - PUC/SP
Avaliação 1
Requisitos: Constructor, Função de visualização, Função de cálculo, Funcçaão que altera o contrato
Contrato de Locação
*/

pragma solidity 0.8.9;

contract contratoDeLocacao {
    
    string constant public locador = "Fulano";
    string constant public naciolidade = "brasileiro";
    string constant public profissao = "advogado";
    uint constant private cpf = 12345;
    string public endereco = "endereco";
    
    string public locatario;
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
    uint public multaDesocupacao;
    uint public multaAtrasoDeAluguel;
    uint public mesesEmAtraso;
    
    string public assinaturaLocador;
    string public assinaturaLocatario;
    
    constructor(
        uint _valorDoAluguel,
        uint _quantidadeDePessoas,
        uint _multaPorPessoasExcedentes,
        uint _multaDesocupacao,
        uint _multaAtrasoDeAluguel,
        uint _prazoDaLocacao,
        uint _mesesEmAtraso,
        string memory _assinaturaLocador,
        string memory _assinaturaLocatario
        
        ) 
    {
        valorDoAluguel = _valorDoAluguel;
        quantidadeDePessoas = _quantidadeDePessoas;
        multaPorPessoasExcedentes= _multaPorPessoasExcedentes;
        multaDesocupacao = _multaDesocupacao;
        multaAtrasoDeAluguel = _multaAtrasoDeAluguel;
        prazoDaLocacao = _prazoDaLocacao;
        mesesEmAtraso = _mesesEmAtraso;
        assinaturaLocador = _assinaturaLocador;
        assinaturaLocatario = _assinaturaLocatario;
    }
    
    function multaPessoasEmExcesso(uint _multaPorPessoasExcedentes) public returns (uint, string memory) {
        multaPorPessoasExcedentes = pessoasExcedentes * (valorDoAluguel * 20/100);
        return(_multaPorPessoasExcedentes, "20 por cento por pessoa excedente");
    }
    function multaPorDesocupacao(uint _multaDesocupacao) public returns (uint, string memory) {
       multaDesocupacao = valorDoAluguel * 2;
       return(_multaDesocupacao, "multa de dois alugeis");
    }
    function multaAluguelAtrasado(uint _multaAtrasoDeAluguel) public returns (uint) {
        multaAtrasoDeAluguel = (valorDoAluguel / prazoDaLocacao) * mesesEmAtraso;
        return(_multaAtrasoDeAluguel);
    }
    
}
