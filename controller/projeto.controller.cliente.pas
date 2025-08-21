unit projeto.controller.cliente;

interface

uses
  SysUtils,
  projeto.controller.interfaces,
  projeto.model.connection.interfaces,
  projeto.model.dto.interfaces,
  projeto.model.dao.interfaces;

type
  TCtrlCliente = class(TinterfacedObject, ICtrlCliente)
  private
    FClienteDao: iClienteDao;

    constructor Create(const pConexao: IConnection);
  public
    function Retorna(const pCodigo: Integer): IClienteDTO;
    function Listar: ILstClienteDTO;

    class function New(const pConexao: IConnection): ICtrlCliente;
  end;

implementation

uses
  projeto.model.dao.cliente,
  projeto.model.adapter;

constructor TCtrlCliente.Create(const pConexao: IConnection);
begin
  inherited Create;
  Self.FClienteDao := TClienteDao.New(pConexao);
end;

function TCtrlCliente.Listar: ILstClienteDTO;
begin
  Result := TAdapterCliente.LstEntityToLstDto(FClienteDao.Listar);
end;

class function TCtrlCliente.New(const pConexao: IConnection): ICtrlCliente;
begin
  Result := Self.Create(pConexao);
end;

function TCtrlCliente.Retorna(const pCodigo: Integer): IClienteDTO;
begin
  Result := TAdapterCliente.EntityToDto(FClienteDao.RetornarPorCodigo(pCodigo));
end;

end.
