unit untDAOInterfaces;

interface

uses
  untEntityInterfaces, untDTOInterfaces, System.SysUtils, untConnection;

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

  TClienteDAO = class(TInterfacedObject, IClienteDAO)
  strict private
    FConn: IConnection;
    FQuery: IQuery;
  private
    constructor Create(const pConexao: IConnection);
    function CriaCliente(const pCod: Integer; const pNome, pCidade, pUf: String): IEntityCliente;
  public
    function RetornarPorCodigo(const pCodigo: Integer): IEntityCliente;
    function Listar: IEntityLstCliente;
    class function New(const pConexao: IConnection): IClienteDAO;
  end;

  TProdDAO = class(TInterfacedObject, IProdDAO)
  strict private
    FConn: IConnection;
    FQuery: IQuery;
  private
    constructor Create(const pConexao: IConnection);
    function CriaProd(const pCod: Integer; const pDesc: String; const pPreco: Currency): IEntityProduto;
  public
    function RetornarPorCodigo(const pCodigo: Integer): IEntityProduto;
    function Listar: IEntityLstProduto;
    class function New(const pConexao: IConnection): IProdDAO;
  end;

  TPedidoDAO = class(TInterfacedObject, IPedidoDAO)
  strict private
    FConn: IConnection;
    FQuery: IQuery;
  private
    constructor Create(const pQuery: IQuery);

    function CriarPedidoItem(const pCod, pCodPedido, pCodProd, pQtd: Integer; pVlrUnit, pVlrTotal: Currency; const pDesc: String): IEntityPedidoItem;
    function CriaPedido(const pNumPedido, pCodCli: Integer; const pDtEmissao: TDateTime; const pValorTotal: Currency; const pNomeCliente: String): IEntityPedido;
    function FloatToDB(const pValue: Currency): String;
  public
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

    class function New(const pQuery: IQuery): IPedidoDAO;
  end;

implementation

uses
  untConsts;

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

procedure TPedidoDao.Cancelar(const pCodigo: Integer);
begin
  try
    Self.FQuery.Exec(Format(_DEL_PEDIDO, [pCodigo]), []);
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao Cancelar Pedido: ' + E.Message);
    end;
  end;
end;

procedure TPedidoDao.CancelarItens(const pCodigo: Integer);
begin
  try
    Self.FQuery.Exec(Format(_DEL_PEDIDO_ITENS, [pCodigo]), []);
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao Cancelar Itens do Pedido: ' + E.Message);
    end;
  end;
end;

constructor TPedidoDao.Create(const pQuery: IQuery);
begin
  inherited Create;
  Self.FQuery := pQuery;
end;

procedure TPedidoDao.EditarItem(const pItem: IPedidoItemDTO);
begin
  try
    Self.FQuery.Exec(Format(_UPD_PEDIDO_ITENS, [pItem.quantidade, pItem.valorUnitario, pItem.valorTotal]), []);
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao Cancelar Pedido: ' + E.Message);
    end;
  end;
end;

function TPedidoDao.Listar(const pCodPessoa: Integer): IEntityLstPedido;
var
  vSQL: String;
begin
  Result := TEntityLstPedido.New;

  vSQL := _SEL_PEDIDO;
  if (pCodPessoa > 0) then
  begin
    vSQL := vSQL + Format(_COND_CLIENTE, [pCodPessoa]);
  end;

  with Self.FQuery.Open(vSQL, []) do
  begin
    while not Eof do
    begin
      Result.AddItem(CriaPedido(FieldByName('NROPEDIDO').AsInteger,
                                FieldByName('CODCLIENTE').AsInteger,
                                FieldByName('DATEMISSAO').AsDateTime,
                                FieldByName('VLRTOTAL').AsCurrency,
                                FieldByName('NOME').AsString));
      Next;
    end;
  end;
end;

class function TPedidoDao.New(const pQuery: IQuery): IPedidoDAO;
begin
  Result := Self.Create(pQuery);
end;

function TPedidoDao.RetornarItemPorCodigo(const pCodigo: Integer): IEntityPedidoItem;
begin
  Result := TEntityPedidoItem.New;
  with Self.FQuery.Open(Format(_SEL_PEDIDO_ITENS + _COND_PEDIDO_ITENS, [pCodigo]), []) do
  begin
    while not Eof do
    begin
      Result := CriarPedidoItem(FieldByName('NROPEDIDO').AsInteger,
                                FieldByName('NROPEDIDOITENS').AsInteger,
                                FieldByName('CODPRODUTO').AsInteger,
                                FieldByName('QUANTIDADE').AsInteger,
                                FieldByName('VLRUNITARIO').AsCurrency,
                                FieldByName('VLRTOTAL').AsCurrency,
                                FieldByName('DESPRODUTO').AsString);
      Next;
    end;
  end;
end;

function TPedidoDao.RetornarItens(const pCodigo: Integer): IEntityLstPedidoItens;
begin
  Result := TEntityLstPedidoItens.New;
  with Self.FQuery.Open(Format(_SEL_PEDIDO_ITENS + _COND_PEDIDO_ITENS, [pCodigo]), []) do
  begin
    while not Eof do
    begin
      Result.AddItem(CriarPedidoItem(FieldByName('NROPEDIDO').AsInteger,
                                     FieldByName('NROPEDIDOITENS').AsInteger,
                                     FieldByName('CODPRODUTO').AsInteger,
                                     FieldByName('QUANTIDADE').AsInteger,
                                     FieldByName('VLRUNITARIO').AsCurrency,
                                     FieldByName('VLRTOTAL').AsCurrency,
                                     FieldByName('DESPRODUTO').AsString));
      Next;
    end;
  end;
end;

function TPedidoDao.RetornarItensCompleto(const pCodigo: Integer): ILstPedidoItensDTO;
var
  lItem: IPedidoItemDTO;
begin
  Result := TLstPedidoItensDTO.New;
  with Self.FQuery.Open(Format(_SEL_PEDIDO_ITENS + _COND_PEDIDO_ITENS, [pCodigo]), []) do
  begin
    while not Eof do
    begin
      lItem := TPedidoItemDTO.New;
      lItem.id := FieldByName('NROPEDIDOITENS').AsInteger;
      lItem.codigoProduto := FieldByName('CODPRODUTO').AsInteger;
      lItem.quantidade := FieldByName('QUANTIDADE').AsInteger;
      lItem.valorUnitario := FieldByName('VLRUNITARIO').AsCurrency;
      lItem.valorTotal := FieldByName('VLRTOTAL').AsCurrency;
      lItem.DescProduto := FieldByName('DESPRODUTO').AsString;
      Result.AddItem(lItem);
      Next;
    end;
  end;
end;

function TPedidoDao.RetornarPorCodigo(const pCodigo: Integer): IEntityPedido;
begin
  Result := TEntityPedido.New;
  with Self.FQuery.Open(Format(_SEL_PEDIDO + _COND_PEDIDO, [pCodigo]), []) do
  begin
    if not IsEmpty then
    begin
      Result.numeroPedido := FieldByName('NROPEDIDO').AsInteger;
      Result.codigoCliente := FieldByName('CODCLIENTE').AsInteger;
      Result.dataEmissao := FieldByName('DATEMISSAO').AsDateTime;
      Result.valorTotal := FieldByName('VLRTOTAL').AsCurrency;
    end;
  end;
end;

function TPedidoDao.Salvar(const pPedido: IPedidoDTO): Integer;
begin
  Result := -1;
  try
    Self.FQuery.Exec(Format(_INS_PEDIDO, [pPedido.codigoCliente, FloatToDB(pPedido.valorTotal)]), []);
    with Self.FQuery.Open(_SEL_MAX, []) do
    begin
      if not IsEmpty then
      begin
        Result := FieldByName('NROPEDIDO').AsInteger;
      end;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao inserir Pedido: ' + E.Message);
    end;
  end;

end;

procedure TPedidoDao.SalvarItem(const pItem: IPedidoItemDTO);
begin
  try
    Self.FQuery.Exec(Format(_INS_PEDIDOITENS, [pItem.numeroPedido, pItem.codigoProduto, pItem.quantidade, FloatToDB(pItem.valorUnitario), FloatToDB(pItem.valorTotal)]), []);
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao inserir Item: ' + E.Message);
    end;
  end;
end;

function TPedidoDao.CriaPedido(const pNumPedido, pCodCli: Integer; const pDtEmissao: TDateTime; const pValorTotal: Currency; const pNomeCliente: String): IEntityPedido;
begin
  Result := TEntityPedido.New;
  Result.numeroPedido := pNumPedido;
  Result.codigoCliente := pCodCli;
  Result.dataEmissao := pDtEmissao;
  Result.valorTotal := pValorTotal;
  Result.nomeCliente := pNomeCliente;
end;

function TPedidoDao.CriarPedidoItem(const pCod, pCodPedido, pCodProd, pQtd: Integer; pVlrUnit, pVlrTotal: Currency; const pDesc: String): IEntityPedidoItem;
begin
  Result := TEntityPedidoItem.New;
  Result.id := pCod;
  Result.numeroPedido := pCodPedido;
  Result.codigoProduto := pCodProd;
  Result.quantidade := pQtd;
  Result.valorUnitario := pVlrUnit;
  Result.valorTotal := pVlrTotal;
end;

function TPedidoDao.FloatToDB(const pValue: Currency): String;
begin
  Result := FloatToStr(pValue);
  Result := StringReplace(Result, '.', '', [rfReplaceAll]);
  Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
end;

end.
