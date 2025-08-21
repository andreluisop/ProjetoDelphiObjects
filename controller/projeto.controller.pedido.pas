unit projeto.controller.pedido;

interface

uses
  SysUtils,
  projeto.controller.interfaces,
  projeto.model.connection.interfaces,
  projeto.model.entity.interfaces,
  projeto.model.dto.interfaces,
  projeto.model.dao.interfaces;

type
  TCtrlPedido = class(TinterfacedObject, ICtrlPedido)
  private
    FPedidoDao: IPedidoDAO;
    FQuery: IQuery;

    constructor Create(const pConexao: IConnection);
  public
    function Retorna(const pCodigo: Integer): IPedidoDTO;
    function Listar(const pCodPessoa: Integer = 0): ILstPedidoDTO;
    function RetornarItemPorCodigo(const pCodigo: Integer): IPedidoItemDTO;
    function RetornarItens(const pCodigo: Integer): ILstPedidoItensDTO;
    function RetornarItensCompletos(const pCodigo: Integer): ILstPedidoItensDTO;
    function CalcularTotal(const pLista: IEntityLstPedidoItens): Currency;

    procedure Cancelar(const pCodigo: Integer);
    procedure EditarItem(const pItem: IEntityPedidoItem);
    procedure Salvar(const pPedido: IEntityPedido);

    class function New(const pConexao: IConnection): ICtrlPedido;
  end;

implementation

uses
  projeto.model.dao.pedido,
  projeto.model.adapter,
  projeto.model.connection.firedac.query;

function TCtrlPedido.CalcularTotal(const pLista: IEntityLstPedidoItens): Currency;
begin
  Result := pLista.getValorTotal;
end;

procedure TCtrlPedido.Cancelar(const pCodigo: Integer);
begin
  try
    FQuery.StartTransaction;

    FPedidoDao.CancelarItens(pCodigo);
    FPedidoDao.Cancelar(pCodigo);

    FQuery.Commit;
  except
    On E: Exception do
    begin
      FQuery.Rollback;
      raise Exception.Create(E.Message);
    end;
  end;
end;

constructor TCtrlPedido.Create(const pConexao: IConnection);
begin
  inherited Create;
  Self.FQuery := TOFDQuery.New(pConexao);
  Self.FPedidoDao := TPedidoDao.New(Self.FQuery);
end;

procedure TCtrlPedido.EditarItem(const pItem: IEntityPedidoItem);
begin
  if (pItem.quantidade > 0) then
  begin
    pItem.valorTotal := pItem.quantidade * pItem.valorUnitario;
    FPedidoDao.EditarItem(TAdapterPedido.EntityItemToDtoItem(pItem))
  end
  else
  begin
    raise Exception.Create('A quantidade do item é inválida');
  end;
end;

function TCtrlPedido.Listar(const pCodPessoa: Integer = 0): ILstPedidoDTO;
begin
  Result := TAdapterPedido.LstEntityToLstDto(FPedidoDao.Listar(pCodPessoa));
end;

class function TCtrlPedido.New(const pConexao: IConnection): ICtrlPedido;
begin
  Result := Self.Create(pConexao);
end;

function TCtrlPedido.Retorna(const pCodigo: Integer): IPedidoDTO;
begin
  Result := TAdapterPedido.EntityToDto(FPedidoDao.RetornarPorCodigo(pCodigo));
end;

function TCtrlPedido.RetornarItemPorCodigo(const pCodigo: Integer): IPedidoItemDTO;
begin
  Result := TAdapterPedido.ItemEntityToItemDto(FPedidoDao.RetornarItemPorCodigo(pCodigo));
  if (Result.id <= 0) then
  begin
    raise Exception.Create('Item não encontrado no pedido');
  end;
end;

function TCtrlPedido.RetornarItens(const pCodigo: Integer): ILstPedidoItensDTO;
begin
  Result := TAdapterPedido.LstItensEntityToLstItensDto(FPedidoDao.RetornarItens(pCodigo));
end;

function TCtrlPedido.RetornarItensCompletos(const pCodigo: Integer): ILstPedidoItensDTO;
begin
  Result := FPedidoDao.RetornarItensCompleto(pCodigo);
end;

procedure TCtrlPedido.Salvar(const pPedido: IEntityPedido);
var
  lId: Integer;
begin
  try
    FQuery.StartTransaction;
    lId := FPedidoDao.Salvar(TAdapterPedido.EntityToDto(pPedido));

    for var lItem in pPedido.Itens.Itens do
    begin
      lItem.numeroPedido := lId;
      FPedidoDao.SalvarItem(TAdapterPedido.EntityItemToDtoItem(lItem));
    end;

    FQuery.Commit;
  except
    on E: Exception do
    begin
      FQuery.Rollback;
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
