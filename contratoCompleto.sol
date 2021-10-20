pragma solidity 0.8.9;

contract CompraeVenda {
    string Comprador;
    string Vendedor;
    
    string public Matricula;
    string public Cartorio;
    
    string DatadeVencimento;
    
    bool Quitado = false;
    
    uint public ValorTotal;
    uint public ValorDeEntrada;
    uint public ValorDaParcela;
    uint public ValorEmAberto;
    uint QuantidadeDeParcelas;
    uint PocentagemdaMulta;
    
    constructor(
        uint _valorTotal,
        uint _valorDaEntrada,
        uint _quantidadeDeParcelas,
        string memory _matricula,
        string memory _cartorio
        ) 
    {
        ValorTotal = _valorTotal;
        ValorDeEntrada = _valorDaEntrada;
        QuantidadeDeParcelas = _quantidadeDeParcelas;
        Matricula = _matricula;
        Cartorio = _cartorio;
        ValorEmAberto = ValorTotal;
        ValorDaParcela = funcaoValorParcela();
    }
    
    function PagaraEntrada(uint _ValorPagamento) public returns (uint, string memory) {
        ValorDeEntrada = _ValorPagamento;
        ValorEmAberto = ValorTotal - _ValorPagamento;
        return (ValorEmAberto, "Valor Em Aberto");
    }
    function PagarParcela(uint _ValorDaParcela) public returns (uint, string memory) {
       ValorEmAberto = ValorEmAberto - _ValorDaParcela;
       return(ValorEmAberto, "valor em aberto");
    }
    function funcaoValorParcela() public view returns (uint) {
        uint CalculoValorParcela = (ValorTotal - ValorDeEntrada)/QuantidadeDeParcelas;
        return(CalculoValorParcela);
    }
    function ValorDaMulta(uint _PorcentagemDaMulta) public view returns(uint, string memory) {
        // uint multa = (_PorcentagemDaMulta/100)/*ValorTotal;
        uint multa = _PorcentagemDaMulta*ValorTotal/100;
        return(multa, "Valor Da Multa");
    }
    
}
