unit projeto.model.entity.interfaces;

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

implementation

end.
