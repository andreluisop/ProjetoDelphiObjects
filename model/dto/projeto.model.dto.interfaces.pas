unit projeto.model.dto.interfaces;

interface

type
  IClienteDTO = interface
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

  ILstClienteDTO = interface
    function getItens: TArray<IClienteDTO>;

    procedure setItens(const pValue: TArray<IClienteDTO>);
    procedure AddItem(const pValue: IClienteDTO);

    property Itens: TArray<IClienteDTO> read getItens write setItens;
  end;

  IProdutoDTO = interface
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

  ILstProdutoDTO = interface
    function getItens: TArray<IProdutoDTO>;

    procedure setItens(const pValue: TArray<IProdutoDTO>);
    procedure AddItem(const pValue: IProdutoDTO);

    property Itens: TArray<IProdutoDTO> read getItens write setItens;
  end;

  IPedidoDTO = interface
    function getNumeroPedido: Integer;
    function getDataEmissao: TDateTime;
    function getCodigoCliente: Integer;
    function getValorTotal: Currency;
    function getNomeCliente: String;

    procedure setNumeroPedido(const pValue: Integer);
    procedure setdataEmissao(const pValue: TDateTime);
    procedure setCodigoCliente(const pValue: Integer);
    procedure setValorTotal(const pValue: Currency);
    procedure setNomeCliente(const pValue: String);

    property numeroPedido: Integer read getNumeroPedido write setNumeroPedido;
    property dataEmissao: TDateTime read getDataEmissao write setdataEmissao;
    property codigoCliente: Integer read getCodigoCliente write setCodigoCliente;
    property valorTotal: Currency read getValorTotal write setValorTotal;
    property nomeCliente: String read getNomeCliente write setNomeCliente;
  end;

  ILstPedidoDTO = interface
    function getItens: TArray<IPedidoDTO>;

    procedure setItens(const pValue: TArray<IPedidoDTO>);
    procedure AddItem(const pValue: IPedidoDTO);

    property Itens: TArray<IPedidoDTO> read getItens write setItens;
  end;

  IPedidoItemDTO = interface
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

    property id: Integer read getId write setId;
    property numeroPedido: Integer read getNumeroPedido write setNumeroPedido;
    property codigoProduto: Integer read getCodigoProduto write setCodigoProduto;
    property DescProduto: String read getDescProduto write setDescProduto;
    property quantidade: Integer read getQuantidade write setQuantidade;
    property valorUnitario: Currency read getValorUnitario write setValorUnitario;
    property valorTotal: Currency read getValorTotal write setValorTotal;
  end;

  ILstPedidoItensDTO = interface
    function getItens: TArray<IPedidoItemDTO>;

    procedure setItens(const pValue: TArray<IPedidoItemDTO>);
    procedure AddItem(const pValue: IPedidoItemDTO);

    property Itens: TArray<IPedidoItemDTO> read getItens write setItens;
  end;

implementation

end.
