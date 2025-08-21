unit projeto.model.dto;

interface

uses
  projeto.model.dto.interfaces;

type
  TClienteDTO = class(TInterfacedObject, IClienteDTO)
  private
    Fcodigo: Integer;
    Fnome: String;
    Fcidade: String;
    Fuf: String;

    function getCodigo: Integer;
    function getNome: String;
    function getCidade: String;
    function getUF: String;

    procedure setCodigo(const pValue: Integer);
    procedure setNome(const pValue: String);
    procedure setCidade(const pValue: String);
    procedure setUF(const pValue: String);
  public
    class function New: IClienteDTO;
  end;

  TLstClienteDTO = class(TInterfacedObject, ILstClienteDTO)
  strict private
    FItens: TArray<IClienteDTO>;
  private
    constructor Create;

    function getItens: TArray<IClienteDTO>;

    procedure setItens(const pValue: TArray<IClienteDTO>);
    procedure AddItem(const pValue: IClienteDTO);
  public
    class function New: ILstClienteDTO;
  end;

  TProdutoDTO = class(TInterfacedObject, IProdutoDTO)
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
    class function New: IProdutoDTO;
  end;

  TLstProdutoDTO = class(TInterfacedObject, ILstProdutoDTO)
  strict private
    FItens: TArray<IProdutoDTO>;
  private
    constructor Create;

    function getItens: TArray<IProdutoDTO>;

    procedure setItens(const pValue: TArray<IProdutoDTO>);
    procedure AddItem(const pValue: IProdutoDTO);
  public
    class function New: ILstProdutoDTO;
  end;

  TPedidoDTO = class(TInterfacedObject, IPedidoDTO)
  strict private
    FnumeroPedido: Integer;
    FdataEmissao: TDateTime;
    FcodigoCliente: Integer;
    FvalorTotal: Currency;
    FnomeCliente: String;
  private
    function getNumeroPedido: Integer;
    function getDataEmissao: TDateTime;
    function getCodigoCliente: Integer;
    function getValorTotal: Currency;
    function getNomeCLiente: String;

    procedure setNumeroPedido(const pValue: Integer);
    procedure setdataEmissao(const pValue: TDateTime);
    procedure setCodigoCliente(const pValue: Integer);
    procedure setValorTotal(const pValue: Currency);
    procedure setNomeCliente(const pValue: String);
  public
    class function New: IPedidoDTO;
  end;

  TLstPedidoDTO = class(TInterfacedObject, ILstPedidoDTO)
  strict private
    FItens: TArray<IPedidoDTO>;
  private
    constructor Create;

    function getItens: TArray<IPedidoDTO>;

    procedure setItens(const pValue: TArray<IPedidoDTO>);
    procedure AddItem(const pValue: IPedidoDTO);
  public
    class function New: ILstPedidoDTO;
  end;

  TPedidoItemDTO = class(TInterfacedObject, IPedidoItemDTO)
  strict private
    Fid: Integer;
    FnumeroPedido: Integer;
    FcodigoProduto: Integer;
    Fquantidade: Integer;
    FvalorUnitario: Currency;
    FvalorTotal: Currency;
    FDescProduto: String;
  private
    function getId: Integer;
    function getNumeroPedido: Integer;
    function getCodigoProduto: Integer;
    function getQuantidade: Integer;
    function getValorUnitario: Currency;
    function getValorTotal: Currency;
    function getDescProduto: String;

    procedure setId(const pValue: Integer);
    procedure setNumeroPedido(const pValue: Integer);
    procedure setCodigoProduto(const pValue: Integer);
    procedure setQuantidade(const pValue: Integer);
    procedure setValorUnitario(const pValue: Currency);
    procedure setValorTotal(const pValue: Currency);
    procedure setDescProduto(const pValue: String);
  public
    class function New: IPedidoItemDTO;
  end;

  TLstPedidoItensDTO = class(TInterfacedObject, ILstPedidoItensDTO)
  strict private
    FItens: TArray<IPedidoItemDTO>;
  private
    constructor Create;

    function getItens: TArray<IPedidoItemDTO>;

    procedure setItens(const pValue: TArray<IPedidoItemDTO>);
    procedure AddItem(const pValue: IPedidoItemDTO);
  public
    class function New: ILstPedidoItensDTO;
  end;

implementation

function TClienteDTO.getCidade: String;
begin
  Result := Self.Fcidade;
end;

function TClienteDTO.getCodigo: Integer;
begin
  Result := Self.Fcodigo;
end;

function TClienteDTO.getNome: String;
begin
  Result := Self.Fnome;
end;

function TClienteDTO.getUF: String;
begin
  Result := Self.Fuf;
end;

class function TClienteDTO.New: IClienteDTO;
begin
  Result := Self.Create;
end;

procedure TClienteDTO.setCidade(const pValue: String);
begin
  Self.Fcidade := pValue;
end;

procedure TClienteDTO.setCodigo(const pValue: Integer);
begin
  Self.Fcodigo := pValue;
end;

procedure TClienteDTO.setNome(const pValue: String);
begin
  Self.Fnome := pValue;
end;

procedure TClienteDTO.setUF(const pValue: String);
begin
  Self.Fuf := pValue;
end;

procedure TLstClienteDTO.AddItem(const pValue: IClienteDTO);
begin
  SetLength(Self.FItens, High(Self.FItens) + 2);
  Self.FItens[High(Self.FItens)] := pValue;
end;

constructor TLstClienteDTO.Create;
begin
  inherited Create;

  SetLength(Self.FItens, 0);
end;

function TLstClienteDTO.getItens: TArray<IClienteDTO>;
begin
  Result := Self.FItens;
end;

class function TLstClienteDTO.New: ILstClienteDTO;
begin
  Result := Self.Create;
end;

procedure TLstClienteDTO.setItens(const pValue: TArray<IClienteDTO>);
begin
  Self.FItens := pValue;
end;

function TProdutoDTO.getCodigo: Integer;
begin
  Result := Self.Fcodigo;
end;

function TProdutoDTO.getDescricao: String;
begin
  Result := Self.Fdescricao;
end;

function TProdutoDTO.getPrecoVenda: Currency;
begin
  Result := Self.FprecoVenda;
end;

class function TProdutoDTO.New: IProdutoDTO;
begin
  Result := Self.Create;
end;

procedure TProdutoDTO.setCodigo(const Value: Integer);
begin
  Self.Fcodigo := Value;
end;

procedure TProdutoDTO.setDescricao(const Value: String);
begin
  Self.Fdescricao := Value;
end;

procedure TProdutoDTO.setPrecoVenda(const Value: Currency);
begin
  Self.FprecoVenda := Value;
end;

procedure TLstProdutoDTO.AddItem(const pValue: IProdutoDTO);
begin
  SetLength(Self.FItens, High(Self.FItens) + 2);
  Self.FItens[High(Self.FItens)] := pValue;
end;

constructor TLstProdutoDTO.Create;
begin
  inherited Create;
  SetLength(Self.FItens, 0);
end;

function TLstProdutoDTO.getItens: TArray<IProdutoDTO>;
begin
  Result := Self.FItens;
end;

class function TLstProdutoDTO.New: ILstProdutoDTO;
begin
  Result := Self.Create;
end;

procedure TLstProdutoDTO.setItens(const pValue: TArray<IProdutoDTO>);
begin
  Self.FItens := pValue;
end;

function TPedidoDTO.getCodigoCliente: Integer;
begin
  Result := Self.FcodigoCliente;
end;

function TPedidoDTO.getDataEmissao: TDateTime;
begin
  Result := Self.FdataEmissao;
end;

function TPedidoDTO.getNomeCLiente: String;
begin
  Result := Self.FnomeCliente;
end;

function TPedidoDTO.getNumeroPedido: Integer;
begin
  Result := Self.FnumeroPedido;
end;

function TPedidoDTO.getValorTotal: Currency;
begin
  Result := Self.FvalorTotal;
end;

class function TPedidoDTO.New: IPedidoDTO;
begin
  Result := Self.Create;
end;

procedure TPedidoDTO.setCodigoCliente(const pValue: Integer);
begin
  Self.FcodigoCliente := pValue;
end;

procedure TPedidoDTO.setdataEmissao(const pValue: TDateTime);
begin
  Self.FdataEmissao := pValue;
end;

procedure TPedidoDTO.setNomeCliente(const pValue: String);
begin
  Self.FnomeCliente := pValue;
end;

procedure TPedidoDTO.setNumeroPedido(const pValue: Integer);
begin
  Self.FnumeroPedido := pValue;
end;

procedure TPedidoDTO.setValorTotal(const pValue: Currency);
begin
  Self.FvalorTotal := pValue;
end;

function TPedidoItemDTO.getCodigoProduto: Integer;
begin
  Result := Self.FcodigoProduto;
end;

function TPedidoItemDTO.getDescProduto: String;
begin
  Result := Self.FDescProduto;
end;

function TPedidoItemDTO.getId: Integer;
begin
  Result := Self.Fid;
end;

function TPedidoItemDTO.getNumeroPedido: Integer;
begin
  Result := Self.FnumeroPedido;
end;

function TPedidoItemDTO.getQuantidade: Integer;
begin
  Result := Self.Fquantidade;
end;

function TPedidoItemDTO.getValorTotal: Currency;
begin
  Result := Self.FvalorTotal;
end;

function TPedidoItemDTO.getValorUnitario: Currency;
begin
  Result := Self.FvalorUnitario;
end;

class function TPedidoItemDTO.New: IPedidoItemDTO;
begin
  Result := Self.Create;
end;

procedure TPedidoItemDTO.setCodigoProduto(const pValue: Integer);
begin
  Self.FcodigoProduto := pValue;
end;

procedure TPedidoItemDTO.setDescProduto(const pValue: String);
begin
  Self.FDescProduto := pValue;
end;

procedure TPedidoItemDTO.setId(const pValue: Integer);
begin
  Self.Fid := pValue;
end;

procedure TPedidoItemDTO.setNumeroPedido(const pValue: Integer);
begin
  Self.FnumeroPedido := pValue;
end;

procedure TPedidoItemDTO.setQuantidade(const pValue: Integer);
begin
  Self.Fquantidade := pValue;
end;

procedure TPedidoItemDTO.setValorTotal(const pValue: Currency);
begin
  Self.FvalorTotal := pValue;
end;

procedure TPedidoItemDTO.setValorUnitario(const pValue: Currency);
begin
  Self.FvalorUnitario := pValue;
end;

procedure TLstPedidoItensDTO.AddItem(const pValue: IPedidoItemDTO);
begin
  SetLength(Self.FItens, High(Self.FItens) + 2);
  Self.FItens[High(Self.FItens)] := pValue;
end;

constructor TLstPedidoItensDTO.Create;
begin
  inherited Create;
  SetLength(Self.FItens, 0);
end;

function TLstPedidoItensDTO.getItens: TArray<IPedidoItemDTO>;
begin
  Result := Self.FItens;
end;

class function TLstPedidoItensDTO.New: ILstPedidoItensDTO;
begin
  Result := Self.Create;
end;

procedure TLstPedidoItensDTO.setItens(const pValue: TArray<IPedidoItemDTO>);
begin
  Self.FItens := pValue;
end;

procedure TLstPedidoDTO.AddItem(const pValue: IPedidoDTO);
begin
  SetLength(Self.FItens, High(Self.FItens) + 2);
  Self.FItens[High(Self.FItens)] := pValue;
end;

constructor TLstPedidoDTO.Create;
begin
  inherited Create;
  SetLength(Self.FItens, 0);
end;

function TLstPedidoDTO.getItens: TArray<IPedidoDTO>;
begin
  Result := Self.FItens;
end;

class function TLstPedidoDTO.New: ILstPedidoDTO;
begin
  Result := Self.Create;
end;

procedure TLstPedidoDTO.setItens(const pValue: TArray<IPedidoDTO>);
begin
  Self.FItens := pValue;
end;

end.
