unit projeto.model.dao.produto;

interface

uses
  System.SysUtils,
  projeto.model.dao.interfaces,
  projeto.model.connection.interfaces,
  projeto.model.entity.interfaces;

type
  TProdDAO = class(TInterfacedObject, IProdDAO)
  private
    FConn: IConnection;
    FQuery: IQuery;

    constructor Create(const pConexao: IConnection);

    function CriaProd(const pCod: Integer; const pDesc: String; const pPreco: Currency): IEntityProduto;
  public
    function RetornarPorCodigo(const pCodigo: Integer): IEntityProduto;
    function Listar: IEntityLstProduto;

    class function New(const pConexao: IConnection): IProdDAO;
  end;

implementation

uses
  projeto.model.dao.consts,
  projeto.model.entity,
  projeto.model.connection.firedac.query;

constructor TProdDAO.Create(const pConexao: IConnection);
begin
  inherited Create;
  Self.FConn := pConexao;
  Self.FQuery := TOFDQuery.New(pConexao);
end;

function TProdDAO.Listar: IEntityLstProduto;
begin
  Result := TEntityLstProduto.New;
  with Self.FQuery.Open(_SEL_PRODUTO, []) do
  begin
    while not Eof do
    begin
      Result.AddItem(CriaProd(FieldByName('CODPRODUTO').AsInteger,
                              FieldByName('DESPRODUTO').AsString,
                              FieldByName('VLRVENDA').AsCurrency));
      Next;
    end;
  end;
end;

class function TProdDAO.New(const pConexao: IConnection): IProdDAO;
begin
  Result := Self.Create(pConexao);
end;

function TProdDAO.RetornarPorCodigo(const pCodigo: Integer): IEntityProduto;
begin
  Result := TEntityProduto.New;
  with Self.FQuery.Open(Format(_SEL_PRODUTO + _COND_PRODUTO, [pCodigo]), []) do
  begin
    if not IsEmpty then
    begin
      Result.codigo := FieldByName('CODPRODUTO').AsInteger;
      Result.descricao := FieldByName('DESPRODUTO').AsString;
      Result.precoVenda := FieldByName('VLRVENDA').AsCurrency;
    end;
  end;
end;

function TProdDAO.CriaProd(const pCod: Integer; const pDesc: String; const pPreco: Currency): IEntityProduto;
begin
  Result := TEntityProduto.New;
  Result.codigo := pCod;
  Result.descricao := pDesc;
  Result.precoVenda := pPreco;
end;

end.
