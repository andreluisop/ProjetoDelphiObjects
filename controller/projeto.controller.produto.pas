unit projeto.controller.produto;

interface

uses
  SysUtils,
  projeto.controller.interfaces,
  projeto.model.connection.interfaces,
  projeto.model.dto.interfaces,
  projeto.model.dao.interfaces;

type
  TCtrlProduto = class(TinterfacedObject, ICtrlProduto)
  private
    FProdutoDao: IProdDAO;

    constructor Create(const pConexao: IConnection);
  public
    function Retorna(const pCodigo: Integer): IProdutoDTO;
    function Listar: ILstProdutoDTO;

    class function New(const pConexao: IConnection): ICtrlProduto;
  end;

implementation

uses
  projeto.model.entity,
  projeto.model.connection.firedac.query,
  projeto.model.dao.produto, projeto.model.adapter;

constructor TCtrlProduto.Create(const pConexao: IConnection);
begin
  inherited Create;
  Self.FProdutoDao := TProdDAO.New(pConexao);
end;

function TCtrlProduto.Listar: ILstProdutoDTO;
begin
  Result := TAdapterProduto.LstEntityToLstDto(FProdutoDao.Listar);
end;

class function TCtrlProduto.New(const pConexao: IConnection): ICtrlProduto;
begin
  Result := Self.Create(pConexao);
end;

function TCtrlProduto.Retorna(const pCodigo: Integer): IProdutoDTO;
begin
  Result := TAdapterProduto.EntityToDto(FProdutoDao.RetornarPorCodigo(pCodigo));
end;

end.
