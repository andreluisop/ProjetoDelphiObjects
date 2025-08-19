unit untEntityInterfaces;

interface

type

  IEntityCliente = interface
    function getCodigo: Integer;
    function getNome: String;
    function getCidade: String;
    function getUF: String;

    procedure setCodigo(const pValue: Integer);
    procedure setNome(const pValue: String);
    procedure setCidade(const pValue: String);
    procedure setUF(const pValue: String);

    property codigo: Integer read getCodigo write setCodigo;
    property nome: String read getNome write setNome;
    property cidade: String read getCidade write setCidade;
    property uf: String read getUF write setUF;
  end;

  IEntityLstCliente = interface
    function getItens: TArray<IEntityCliente>;

    procedure setItens(const pValue: TArray<IEntityCliente>);
    procedure AddItem(const pValue: IEntityCliente);

    property Itens: TArray<IEntityCliente> read getItens write setItens;
  end;

  IEntityProduto = interface
    function getCodigo: Integer;
    function getDescricao: String;
    function getPrecoVenda: Currency;

    procedure setCodigo(const Value: Integer);
    procedure setDescricao(const Value: String);
    procedure setPrecoVenda(const Value: Currency);

    property codigo: Integer read getCodigo write setCodigo;
    property descricao: String read getDescricao write setDescricao;
    property precoVenda: Currency read getPrecoVenda write setPrecoVenda;
  end;

  IEntityLstProduto = interface
    function getItens: TArray<IEntityProduto>;

    procedure setItens(const pValue: TArray<IEntityProduto>);
    procedure AddItem(const pValue: IEntityProduto);

    property Itens: TArray<IEntityProduto> read getItens write setItens;
  end;

  IEntityPedidoItem = interface
    function getId: Integer;
    function getNumeroPedido: Integer;
    function getCodigoProduto: Integer;
    function getQuantidade: Integer;
    function getValorUnitario: Currency;
    function getValorTotal: Currency;

    procedure setId(const pValue: Integer);
    procedure setNumeroPedido(const pValue: Integer);
    procedure setCodigoProduto(const pValue: Integer);
    procedure setQuantidade(const pValue: Integer);
    procedure setValorUnitario(const pValue: Currency);
    procedure setValorTotal(const pValue: Currency);

    property id: Integer read getId write setId;
    property numeroPedido: Integer read getNumeroPedido write setNumeroPedido;
    property codigoProduto: Integer read getCodigoProduto write setCodigoProduto;
    property quantidade: Integer read getQuantidade write setQuantidade;
    property valorUnitario: Currency read getValorUnitario write setValorUnitario;
    property valorTotal: Currency read getValorTotal write setValorTotal;
  end;

  IEntityLstPedidoItens = interface
    function getItens: TArray<IEntityPedidoItem>;
    function getValorTotal: Currency;

    procedure setItens(const pValue: TArray<IEntityPedidoItem>);
    procedure AddItem(const pValue: IEntityPedidoItem);

    property Itens: TArray<IEntityPedidoItem> read getItens write setItens;
  end;

  IEntityPedido = interface
    function getNumeroPedido: Integer;
    function getDataEmissao: TDateTime;
    function getCodigoCliente: Integer;
    function getValorTotal: Currency;
    function getNomeCliente: String;
    function getItens: IEntityLstPedidoItens;

    procedure setNumeroPedido(const pValue: Integer);
    procedure setdataEmissao(const pValue: TDateTime);
    procedure setCodigoCliente(const pValue: Integer);
    procedure setValorTotal(const pValue: Currency);
    procedure setNomeCliente(const pValue: String);
    procedure setItens(const pValue: IEntityLstPedidoItens);

    property numeroPedido: Integer read getNumeroPedido write setNumeroPedido;
    property dataEmissao: TDateTime read getDataEmissao write setdataEmissao;
    property codigoCliente: Integer read getCodigoCliente write setCodigoCliente;
    property nomeCliente: String read getNomeCliente write setNomeCliente;
    property valorTotal: Currency read getValorTotal write setValorTotal;
    property Itens: IEntityLstPedidoItens read getItens write setItens;
  end;

  IEntityLstPedido = interface
    function getItens: TArray<IEntityPedido>;

    procedure setItens(const pValue: TArray<IEntityPedido>);
    procedure AddItem(const pValue: IEntityPedido);

    property Itens: TArray<IEntityPedido> read getItens write setItens;
  end;

  TEntityCliente = class(TInterfacedObject, IEntityCliente)
  strict private
    Fcodigo: Integer;
    Fnome: String;
    Fcidade: String;
    Fuf: String;
  private
    function getCodigo: Integer;
    function getNome: String;
    function getCidade: String;
    function getUF: String;

    procedure setCodigo(const pValue: Integer);
    procedure setNome(const pValue: String);
    procedure setCidade(const pValue: String);
    procedure setUF(const pValue: String);
  public
    class function New: IEntityCliente;
  end;

  TEntityLstCliente = class(TInterfacedObject, IEntityLstCliente)
    constructor Create;
  strict private
    FItens: TArray<IEntityCliente>;
  private
    function getItens: TArray<IEntityCliente>;

    procedure setItens(const pValue: TArray<IEntityCliente>);
    procedure AddItem(const pValue: IEntityCliente);
  public
    class function New: IEntityLstCliente;
  end;

  TEntityProduto = class(TInterfacedObject, IEntityProduto)
  strict private
    Fcodigo: Integer;
    Fdescricao: String;
    FprecoVenda: Currency;
  private
    function getCodigo: Integer;
    function getDescricao: String;
    function getPrecoVenda: Currency;

    procedure setCodigo(const Value: Integer);
    procedure setDescricao(const Value: String);
    procedure setPrecoVenda(const Value: Currency);
  public
    class function New: IEntityProduto;
  end;

  TEntityLstProduto = class(TInterfacedObject, IEntityLstProduto) constructor Create;
  strict private
    FItens: TArray<IEntityProduto>;
  private
    function getItens: TArray<IEntityProduto>;

    procedure setItens(const pValue: TArray<IEntityProduto>);
    procedure AddItem(const pValue: IEntityProduto);
  public
    class function New: IEntityLstProduto;
  end;

  TEntityPedido = class(TInterfacedObject, IEntityPedido)
  strict private
    FnumeroPedido: Integer;
    FdataEmissao: TDateTime;
    FcodigoCliente: Integer;
    FvalorTotal: Currency;
    FNomeCliente: String;
    FItens: IEntityLstPedidoItens;
  private
    constructor Create;

    function getNumeroPedido: Integer;
    function getDataEmissao: TDateTime;
    function getCodigoCliente: Integer;
    function getValorTotal: Currency;
    function getItens: IEntityLstPedidoItens;
    function getNomeCliente: String;

    procedure setNumeroPedido(const pValue: Integer);
    procedure setdataEmissao(const pValue: TDateTime);
    procedure setCodigoCliente(const pValue: Integer);
    procedure setValorTotal(const pValue: Currency);
    procedure setItens(const pValue: IEntityLstPedidoItens);
    procedure setNomeCliente(const pValue: String);
  public
    class function New: IEntityPedido;
  end;

  TEntityLstPedido = class(TInterfacedObject, IEntityLstPedido)
  strict private
    FItens: TArray<IEntityPedido>;
  private
    constructor Create;

    function getItens: TArray<IEntityPedido>;

    procedure setItens(const pValue: TArray<IEntityPedido>);
    procedure AddItem(const pValue: IEntityPedido);
  public
    class function New: IEntityLstPedido;
  end;

  TEntityPedidoItem = class(TInterfacedObject, IEntityPedidoItem)
  strict private
    Fid: Integer;
    FnumeroPedido: Integer;
    FcodigoProduto: Integer;
    Fquantidade: Integer;
    FvalorUnitario: Currency;
    FvalorTotal: Currency;
  private
    function getId: Integer;
    function getNumeroPedido: Integer;
    function getCodigoProduto: Integer;
    function getQuantidade: Integer;
    function getValorUnitario: Currency;
    function getValorTotal: Currency;

    procedure setId(const pValue: Integer);
    procedure setNumeroPedido(const pValue: Integer);
    procedure setCodigoProduto(const pValue: Integer);
    procedure setQuantidade(const pValue: Integer);
    procedure setValorUnitario(const pValue: Currency);
    procedure setValorTotal(const pValue: Currency);
  public
    class function New: IEntityPedidoItem;
  end;

  TEntityLstPedidoItens = class(TInterfacedObject, IEntityLstPedidoItens)
  strict private
    FItens: TArray<IEntityPedidoItem>;
  private
    constructor Create;

    function getItens: TArray<IEntityPedidoItem>;
    function getValorTotal: Currency;

    procedure setItens(const pValue: TArray<IEntityPedidoItem>);
    procedure AddItem(const pValue: IEntityPedidoItem);
  public
    class function New: IEntityLstPedidoItens;
  end;

implementation

function TEntityCliente.getCidade: String;
begin
  Result := Self.Fcidade;
end;

function TEntityCliente.getCodigo: Integer;
begin
  Result := Self.Fcodigo;
end;

function TEntityCliente.getNome: String;
begin
  Result := Self.Fnome;
end;

function TEntityCliente.getUF: String;
begin
  Result := Self.Fuf;
end;

class function TEntityCliente.New: IEntityCliente;
begin
  Result := Self.Create;
end;

procedure TEntityCliente.setCidade(const pValue: String);
begin
  Self.Fcidade := pValue;
end;

procedure TEntityCliente.setCodigo(const pValue: Integer);
begin
  Self.Fcodigo := pValue;
end;

procedure TEntityCliente.setNome(const pValue: String);
begin
  Self.Fnome := pValue;
end;

procedure TEntityCliente.setUF(const pValue: String);
begin
  Self.Fuf := pValue;
end;

procedure TEntityLstCliente.AddItem(const pValue: IEntityCliente);
begin
  SetLength(Self.FItens, High(Self.FItens) + 2);
  Self.FItens[High(Self.FItens)] := pValue;
end;

constructor TEntityLstCliente.Create;
begin
  inherited Create;
  SetLength(Self.FItens, 0);
end;

function TEntityLstCliente.getItens: TArray<IEntityCliente>;
begin
  Result := Self.FItens;
end;

class function TEntityLstCliente.New: IEntityLstCliente;
begin
  Result := Self.Create;
end;

procedure TEntityLstCliente.setItens(const pValue: TArray<IEntityCliente>);
begin
  Self.FItens := pValue;
end;

function TEntityProduto.getCodigo: Integer;
begin
  Result := Self.Fcodigo;
end;

function TEntityProduto.getDescricao: String;
begin
  Result := Self.Fdescricao;
end;

function TEntityProduto.getPrecoVenda: Currency;
begin
  Result := Self.FprecoVenda;
end;

class function TEntityProduto.New: IEntityProduto;
begin
  Result := Self.Create;
end;

procedure TEntityProduto.setCodigo(const Value: Integer);
begin
  Self.Fcodigo := Value;
end;

procedure TEntityProduto.setDescricao(const Value: String);
begin
  Self.Fdescricao := Value;
end;

procedure TEntityProduto.setPrecoVenda(const Value: Currency);
begin
  Self.FprecoVenda := Value;
end;

procedure TEntityLstProduto.AddItem(const pValue: IEntityProduto);
begin
  SetLength(Self.FItens, High(Self.FItens) + 2);
  Self.FItens[High(Self.FItens)] := pValue;
end;

constructor TEntityLstProduto.Create;
begin
  inherited Create;
  SetLength(Self.FItens, 0);
end;

function TEntityLstProduto.getItens: TArray<IEntityProduto>;
begin
  Result := Self.FItens;
end;

class function TEntityLstProduto.New: IEntityLstProduto;
begin
  Result := Self.Create;
end;

procedure TEntityLstProduto.setItens(const pValue: TArray<IEntityProduto>);
begin
  Self.FItens := pValue;
end;

constructor TEntityPedido.Create;
begin
  inherited Create;
  Self.FItens := TEntityLstPedidoItens.New;
end;

function TEntityPedido.getCodigoCliente: Integer;
begin
  Result := Self.FcodigoCliente;
end;

function TEntityPedido.getDataEmissao: TDateTime;
begin
  Result := Self.FdataEmissao;
end;

function TEntityPedido.getItens: IEntityLstPedidoItens;
begin
  Result := Self.FItens;
end;

function TEntityPedido.getNomeCliente: String;
begin
  Result := Self.FNomeCliente;
end;

function TEntityPedido.getNumeroPedido: Integer;
begin
  Result := Self.FnumeroPedido;
end;

function TEntityPedido.getValorTotal: Currency;
begin
  Result := Self.FvalorTotal;
end;

class function TEntityPedido.New: IEntityPedido;
begin
  Result := Self.Create;
end;

procedure TEntityPedido.setCodigoCliente(const pValue: Integer);
begin
  Self.FcodigoCliente := pValue;
end;

procedure TEntityPedido.setdataEmissao(const pValue: TDateTime);
begin
  Self.FdataEmissao := pValue;
end;

procedure TEntityPedido.setItens(const pValue: IEntityLstPedidoItens);
begin
  Self.FItens := pValue;
end;

procedure TEntityPedido.setNomeCliente(const pValue: String);
begin
  Self.FNomeCliente := pValue
end;

procedure TEntityPedido.setNumeroPedido(const pValue: Integer);
begin
  Self.FnumeroPedido := pValue;
end;

procedure TEntityPedido.setValorTotal(const pValue: Currency);
begin
  Self.FvalorTotal := pValue;
end;

function TEntityPedidoItem.getCodigoProduto: Integer;
begin
  Result := Self.FcodigoProduto;
end;

function TEntityPedidoItem.getId: Integer;
begin
  Result := Self.Fid;
end;

function TEntityPedidoItem.getNumeroPedido: Integer;
begin
  Result := Self.FnumeroPedido;
end;

function TEntityPedidoItem.getQuantidade: Integer;
begin
  Result := Self.Fquantidade;
end;

function TEntityPedidoItem.getValorTotal: Currency;
begin
  Result := Self.FvalorTotal;
end;

function TEntityPedidoItem.getValorUnitario: Currency;
begin
  Result := Self.FvalorUnitario;
end;

class function TEntityPedidoItem.New: IEntityPedidoItem;
begin
  Result := Self.Create;
end;

procedure TEntityPedidoItem.setCodigoProduto(const pValue: Integer);
begin
  Self.FcodigoProduto := pValue;
end;

procedure TEntityPedidoItem.setId(const pValue: Integer);
begin
  Self.Fid := pValue;
end;

procedure TEntityPedidoItem.setNumeroPedido(const pValue: Integer);
begin
  Self.FnumeroPedido := pValue;
end;

procedure TEntityPedidoItem.setQuantidade(const pValue: Integer);
begin
  Self.Fquantidade := pValue;
end;

procedure TEntityPedidoItem.setValorTotal(const pValue: Currency);
begin
  Self.FvalorTotal := pValue;
end;

procedure TEntityPedidoItem.setValorUnitario(const pValue: Currency);
begin
  Self.FvalorUnitario := pValue;
end;

procedure TEntityLstPedidoItens.AddItem(const pValue: IEntityPedidoItem);
begin
  SetLength(Self.FItens, High(Self.FItens) + 2);
  Self.FItens[High(Self.FItens)] := pValue;
end;

constructor TEntityLstPedidoItens.Create;
begin
  inherited Create;
  SetLength(Self.FItens, 0);
end;

function TEntityLstPedidoItens.getItens: TArray<IEntityPedidoItem>;
begin
  Result := Self.FItens;
end;

function TEntityLstPedidoItens.getValorTotal: Currency;
begin
  Result := 0;
  for var lItem in Self.FItens do
  begin
    Result := Result + (lItem.quantidade * lItem.valorUnitario);
  end;
end;

class function TEntityLstPedidoItens.New: IEntityLstPedidoItens;
begin
  Result := Self.Create;
end;

procedure TEntityLstPedidoItens.setItens(const pValue: TArray<IEntityPedidoItem>);
begin
  Self.FItens := pValue;
end;

procedure TEntityLstPedido.AddItem(const pValue: IEntityPedido);
begin
  SetLength(Self.FItens, High(Self.FItens) + 2);
  Self.FItens[High(Self.FItens)] := pValue;
end;

constructor TEntityLstPedido.Create;
begin
  inherited Create;
  SetLength(Self.FItens, 0);
end;

function TEntityLstPedido.getItens: TArray<IEntityPedido>;
begin
  Result := Self.FItens;
end;

class function TEntityLstPedido.New: IEntityLstPedido;
begin
  Result := Self.Create;
end;

procedure TEntityLstPedido.setItens(const pValue: TArray<IEntityPedido>);
begin
  Self.FItens := pValue;
end;

end.
