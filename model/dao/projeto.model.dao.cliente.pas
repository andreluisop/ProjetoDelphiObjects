unit projeto.model.dao.cliente;

interface

uses
  System.SysUtils,
  projeto.model.dao.interfaces,
  projeto.model.connection.interfaces,
  projeto.model.Entity.interfaces;

type
  TClienteDAO = class(TInterfacedObject, IClienteDAO)
  private
    FConn: IConnection;
    FQuery: IQuery;

    constructor Create(const pConexao: IConnection);

    function CriaCliente(const pCod: Integer; const pNome, pCidade, pUf: String): IEntityCliente;
  public
    function RetornarPorCodigo(const pCodigo: Integer): IEntityCliente;
    function Listar: IEntityLstCliente;

    class function New(const pConexao: IConnection): IClienteDAO;
  end;

implementation

uses
  projeto.model.dao.consts,
  projeto.model.entity,
  projeto.model.connection.firedac.query;

constructor TClienteDao.Create(const pConexao: IConnection);
begin
  inherited Create;
  Self.FConn := pConexao;
  Self.FQuery := TOFDQuery.New(pConexao);
end;

function TClienteDao.Listar: IEntityLstCliente;
begin
  Result := TEntityLstCliente.New;
  with Self.FQuery.Open(_SEL_CLIENTE, []) do
  begin
    while not Eof do
    begin
      Result.AddItem(CriaCliente(FieldByName('CODCLIENTE').AsInteger,
                                 FieldByName('NOME').AsString,
                                 FieldByName('CIDADE').AsString,
                                 FieldByName('UF').AsString));
      Next;
    end;
  end;
end;

class function TClienteDao.New(const pConexao: IConnection): IClienteDAO;
begin
  Result := Self.Create(pConexao);
end;

function TClienteDao.RetornarPorCodigo(const pCodigo: Integer): IEntityCliente;
begin
  Result := TEntityCliente.New;
  with Self.FQuery.Open(Format(_SEL_CLIENTE + _COND_CLIENTE, [pCodigo]), []) do
  begin
    if not IsEmpty then
    begin
      Result.codigo := FieldByName('CODCLIENTE').AsInteger;
      Result.nome := FieldByName('NOME').AsString;
      Result.cidade := FieldByName('CIDADE').AsString;
      Result.uf := FieldByName('UF').AsString;
    end;
  end;
end;

function TClienteDao.CriaCliente(const pCod: Integer; const pNome, pCidade, pUf: String): IEntityCliente;
begin
  Result := TEntityCliente.New;
  Result.codigo := pCod;
  Result.nome := pNome;
  Result.cidade := pCidade;
  Result.uf := pUf;
end;

end.
