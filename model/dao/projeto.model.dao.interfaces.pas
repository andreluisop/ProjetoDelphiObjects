unit projeto.model.dao.interfaces;

interface

uses
  projeto.model.entity.interfaces,
  projeto.model.dto.interfaces;

type

  IProdDAO = interface
    function RetornarPorCodigo(const pCodigo: Integer): IEntityProduto;
    function Listar: IEntityLstProduto;
  end;

  IClienteDAO = interface
    function RetornarPorCodigo(const pCodigo: Integer): IEntityCliente;
    function Listar: IEntityLstCliente;
  end;

  IPedidoDAO = interface
    function RetornarPorCodigo(const pCodigo: Integer): IEntityPedido;
    function Listar(const pCodPessoa: Integer): IEntityLstPedido;
    function RetornarItens(const pCodigo: Integer): IEntityLstPedidoItens;
    function RetornarItensCompleto(const pCodigo: Integer): ILstPedidoItensDTO;
    function RetornarItemPorCodigo(const pCodigo: Integer): IEntityPedidoItem;
    function Salvar(const pPedido: IPedidoDTO): Integer;
    procedure Cancelar(const pCodigo: Integer);
    procedure CancelarItens(const pCodigo: Integer);
    procedure EditarItem(const pItem: IPedidoItemDTO);
    procedure SalvarItem(const pItem: IPedidoItemDTO);
  end;

implementation

end.
