unit untPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls,
  untCtrlInterfaces;

type
  TfrmVisualPedidos = class(TForm)
    pnlPrincipal: TPanel;
    pnlDados: TPanel;
    pnlCabecalho: TPanel;
    lvItens: TListView;
    lvPedidos: TListView;
    pnlSuperior: TPanel;
    lblFiltroCliente: TLabel;
    cbxCliente: TComboBox;
    btnPesquisar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnPesquisarClick(Sender: TObject);
    procedure lvPedidosChange(Sender: TObject; Item: TListItem; Change: TItemChange);
  private
    { Private declarations }

    FCtrlPedido: ICtrlPedido;
    FCtrlCliente: ICtrlCliente;
    FCtrlProduto: ICtrlProduto;

    procedure ResfreshGrade;
  public
    { Public declarations }

    procedure putCtrlPedido(const pCtrl: ICtrlPedido);
    procedure putCtrlCliente(const pCtrl: ICtrlCliente);

    procedure Inicializar;

    procedure PreencherComboCliente;
    procedure CarregarDados;
    procedure CarregarItens(const pCod: Integer);
  end;

var
  frmVisualPedidos: TfrmVisualPedidos;

implementation

{$R *.dfm}

uses
  untEntityInterfaces, untDTOInterfaces;

procedure TfrmVisualPedidos.btnPesquisarClick(Sender: TObject);
var
  lItem: TListItem;
  lPedido: IPedidoDTO;
begin
  lvPedidos.Clear;
  for lPedido in FCtrlPedido.Listar(Integer(cbxCliente.Items.Objects[cbxCliente.ItemIndex])).Itens do
  begin
    lItem := lvPedidos.Items.Add;
    lItem.Caption := IntToStr(lPedido.numeroPedido);
    lItem.SubItems.Add(IntToStr(lPedido.codigoCliente));
    lItem.SubItems.Add(lPedido.nomeCliente);
    lItem.SubItems.Add(FormatDateTime('DD/MM/YYYY', lPedido.dataEmissao));
    lItem.SubItems.Add(FormatFloat('R$ #,##0.00', lPedido.valorTotal));
  end;

  if (lvPedidos.Items.Count > 0) then
  begin
    lvPedidos.ItemIndex := 0;
    ResfreshGrade;
  end
  else
  begin
    lvItens.Clear;
  end;
end;

procedure TfrmVisualPedidos.CarregarDados;
begin
  if (lvPedidos.Items.Count > 0) and (StrToInt(lvPedidos.Items[lvPedidos.ItemIndex].SubItems[0]) > 0) then
  begin
    CarregarItens(StrToInt(lvPedidos.Items[lvPedidos.ItemIndex].Caption));
  end;
end;

procedure TfrmVisualPedidos.CarregarItens(const pCod: Integer);
var
  lPedidoItem: IPedidoItemDTO;
  lItem: TListItem;
begin
  lvItens.Clear;
  for lPedidoItem in FCtrlPedido.RetornarItensCompletos(pCod).Itens do
  begin
    lItem := lvItens.Items.Add;
    lItem.Caption := IntToStr(lPedidoItem.Id);
    lItem.SubItems.Add(lPedidoItem.DescProduto);
    lItem.SubItems.Add(IntToStr(lPedidoItem.quantidade));
    lItem.SubItems.Add(FormatFloat('R$ #,##0.00', lPedidoItem.valorUnitario));
    lItem.SubItems.Add(FormatFloat('R$ #,##0.00', lPedidoItem.valorTotal));
  end;
end;

procedure TfrmVisualPedidos.Inicializar;
begin
  PreencherComboCliente;
  cbxCliente.ItemIndex := 0;
end;

procedure TfrmVisualPedidos.ResfreshGrade;
begin
  if (lvPedidos.ItemIndex >= 0) then
  begin
    CarregarDados;
  end;
end;

procedure TfrmVisualPedidos.lvPedidosChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  ResfreshGrade;
end;

procedure TfrmVisualPedidos.PreencherComboCliente;
begin
  cbxCliente.Items.Clear;
  cbxCliente.AddItem('Todos', TObject(-1));
  for var lItem in FCtrlCliente.Listar.Itens do
  begin
    cbxCliente.AddItem(lItem.nome, TObject(lItem.codigo));
  end;
end;

procedure TfrmVisualPedidos.putCtrlCliente(const pCtrl: ICtrlCliente);
begin
  Self.FCtrlCliente := pCtrl;
end;

procedure TfrmVisualPedidos.putCtrlPedido(const pCtrl: ICtrlPedido);
begin
  Self.FCtrlPedido := pCtrl;
end;

end.
