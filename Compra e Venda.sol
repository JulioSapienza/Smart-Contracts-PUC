pragma solidity 0.8.9;

contract CompraeVenda {
    string Comprador;
    string Vendedor;
    string Matricula;
    string Cartorio;
    string DatadeVencimento;
    bool Quitado = false;
    uint ValorTotal;
    uint ValordeEntrada;
    uint ValordaParcela;
    uint ValorEmAberto;
    uint QuantidadedeParcelas;
    uint PocentagemdaMulta;
    
    function PagaraEntrada(uint _ValorPagamento) public returns (uint, string memory) {
        ValordeEntrada = _ValorPagamento;
        ValorEmAberto = ValorTotal - _ValorPagamento;
        return (ValorEmAberto, "Valor Em Aberto");
    }
    
}
