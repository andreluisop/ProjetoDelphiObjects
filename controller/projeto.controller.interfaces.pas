unit projeto.controller.interfaces;

interface

uses
  projeto.model.entity.interfaces,
  projeto.model.dto.interfaces;

type
  ICtrlProduto = interface
    function Retorna(const pCodigo: Integer): IProdutoDTO;
    function Listar: ILstProdutoDTO;
  end;

  ICtrlCliente = interface
    function Retorna(const pCodigo: Integer): IClienteDTO;
    function Listar: ILstClienteDTO;
  end;

  ICtrlPedido = interface
    function Retorna(const pCodigo: Integer): IPedidoDTO;
    function Listar(const pCodPessoa: Integer = 0): ILstPedidoDTO;
    function RetornarItemPorCodigo(const pCodigo: Integer): IPedidoItemDTO;
    function RetornarItens(const pCodigo: Integer): ILstPedidoItensDTO;
    function RetornarItensCompletos(const pCodigo: Integer): ILstPedidoItensDTO;
    function CalcularTotal(const pLista: IEntityLstPedidoItens): Currency;

    procedure Cancelar(const pCodigo: Integer);
    procedure EditarItem(const pItem: IEntityPedidoItem);
    procedure Salvar(const pPedido: IEntityPedido);
  end;

implementation

end.
