unit projeto.view.principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, System.UITypes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, Vcl.Mask,
  projeto.controller.interfaces,
  projeto.model.entity.interfaces;

type
  TfrmMain = class(TForm)
    pgcCtrlMain: TPageControl;
    tbsPedidos: TTabSheet;
    tbsVisualizar: TTabSheet;
    pnlPrincipal: TPanel;
    pnlDados: TPanel;
    pnlCabecalho: TPanel;
    lblClienteNome: TLabel;
    lblClienteCidade: TLabel;
    lblClienteUF: TLabel;
    lblProdutoQtd: TLabel;
    lblProdutoDescricao: TLabel;
    lblProdutoValorUnit: TLabel;
    lblCodigoCliente: TLabel;
    lblCodProduto: TLabel;
    cbxCliente: TComboBox;
    edtCidade: TEdit;
    edtUF: TEdit;
    edtQuantidade: TEdit;
    cbxProduto: TComboBox;
    edtValorUnitario: TMaskEdit;
    btnIncluirSalvar: TButton;
    edtCodigoCliente: TEdit;
    edtCodigoProduto: TEdit;
    lvItens: TListView;
    pnlRodape: TPanel;
    pnlDireita: TPanel;
    btnEditarItem: TButton;
    btncancelarItem: TButton;
    btnCancelarPedido: TButton;
    btnSalvarPedido: TButton;
    lblTotalRodape: TLabel;
    procedure btnSalvarPedidoClick(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure btnEditarItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbxClienteChange(Sender: TObject);
    procedure cbxProdutoChange(Sender: TObject);
    procedure btnVisualizarPedidosClick(Sender: TObject);
    procedure btnIncluirSalvarClick(Sender: TObject);
    procedure btncancelarItemClick(Sender: TObject);
    procedure edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
  private
    FCtrlPedido: ICtrlPedido;
    FCtrlCliente: ICtrlCliente;
    FCtrlProduto: ICtrlProduto;
    FLstItens: IEntityLstPedidoItens;

    function FormToEntity: IEntityPedido;
    function RetNumero(Key: Char; Texto: string; EhDecimal: Boolean): Char;

    procedure Inicializar;
    procedure PreencherComboCliente;
    procedure PreencherComboProduto;
    procedure LimparCliente;
    procedure LimparProduto;
    procedure FormAddProduto;
    procedure AtualizaTotal;
    procedure MsgWarning(const pTexto: String);
    procedure PrepararFormAposFinalizar;
    procedure DeletarItemLista;
    procedure AtualizarItemDaLista;
    procedure ExibirBotaoCancelar;
    procedure EditandoItem(const pEmEdicao: Boolean);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  projeto.view.pedido,
  projeto.model.entity,
  projeto.model.connection.firedac,
  projeto.model.connection.interfaces,
  projeto.controller.cliente,
  projeto.controller.pedido,
  projeto.controller.produto;

{$R *.dfm}

procedure TfrmMain.AtualizarItemDaLista;
var
  lNovaLista: IEntityLstPedidoItens;
  lSelecionado: integer;
begin
  lSelecionado := lvItens.ItemIndex;

  FLstItens.Itens[lSelecionado].quantidade := StrToInt(edtQuantidade.Text);
  FLstItens.Itens[lSelecionado].valorUnitario := StrToFloat(edtValorUnitario.Text);

  lvItens.Items[lSelecionado].SubItems[1] := edtQuantidade.Text;
  lvItens.Items[lSelecionado].SubItems[2] := edtValorUnitario.Text;
  lvItens.Items[lSelecionado].SubItems[3] := FormatFloat('#,##0.00', StrToInt(edtQuantidade.Text) * StrToFloat(edtValorUnitario.Text));

  AtualizaTotal;
end;

procedure TfrmMain.AtualizaTotal;
begin
  lblTotalRodape.Caption := FormatFloat('Valor Total: R$ #,##0.00', FLstItens.getValorTotal);
end;

procedure TfrmMain.btncancelarItemClick(Sender: TObject);
begin
  if (lvItens.ItemIndex >= 0) then
  begin
    if MessageDlg('Deseja Cancelar este Item?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      DeletarItemLista;
    end;
  end;
end;

procedure TfrmMain.btnCancelarPedidoClick(Sender: TObject);
begin
  if MessageDlg('Deseja Cancelar este Pedido?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    PrepararFormAposFinalizar;
  end;
end;

procedure TfrmMain.btnEditarItemClick(Sender: TObject);
begin
  if (lvItens.ItemIndex >= 0) then
  begin
    if MessageDlg('Deseja Editar este Item?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if edtQuantidade.CanFocus then
      begin
        edtQuantidade.SetFocus;
      end;

      edtCodigoProduto.Text := lvItens.Items[lvItens.ItemIndex].Caption;
      cbxProduto.ItemIndex := cbxProduto.Items.IndexOf(lvItens.Items[lvItens.ItemIndex].SubItems[0]);
      edtQuantidade.Text := lvItens.Items[lvItens.ItemIndex].SubItems[1];
      edtValorUnitario.Text := lvItens.Items[lvItens.ItemIndex].SubItems[2];
      EditandoItem(True)
    end;
  end;
end;

procedure TfrmMain.btnIncluirSalvarClick(Sender: TObject);
begin
  if (StrToIntDef(edtQuantidade.Text, 0) <= 0) then
  begin
    MsgWarning('Por favor, informe uma quantidade válida!');
    exit;
  end;

  if (StrToFloatDef(edtValorUnitario.Text, 0) <= 0) then
  begin
    MsgWarning('Por favor, informe um valor unitário válido!');
    exit;
  end;

  if btnIncluirSalvar.Caption = 'Salvar' then
  begin
    AtualizarItemDaLista;
    lvItens.Enabled := True;
    EditandoItem(False);
  end
  else
  begin
    FormAddProduto;
  end;

  cbxProduto.ItemIndex := 0;
  LimparProduto;
end;

procedure TfrmMain.btnSalvarPedidoClick(Sender: TObject);
begin
  if (edtCodigoCliente.Text = '') then
  begin
    MsgWarning('Por favor, escolha o Cliente!');
    exit;
  end;

  if (lvItens.Items.Count <= 0) then
  begin
    MsgWarning('Por favor, escolha um produto!');
    exit;
  end;

  FCtrlPedido.Salvar(FormToEntity);

  PrepararFormAposFinalizar;

  MessageDlg('Pedido registrado com sucesso!', TMsgDlgType.mtInformation, [mbOk], 0);
end;

procedure TfrmMain.btnVisualizarPedidosClick(Sender: TObject);
var
  lFrmPedido: TfrmVisualPedidos;
begin

  try
    lFrmPedido := TfrmVisualPedidos.Create(Nil);
    lFrmPedido.putCtrlPedido(Self.FCtrlPedido);
    lFrmPedido.putCtrlCliente(Self.FCtrlCliente);
    lFrmPedido.Inicializar;
    lFrmPedido.ShowModal;
  finally
    FreeAndNil(lFrmPedido);
  end;
end;

procedure TfrmMain.cbxClienteChange(Sender: TObject);
begin
  LimparCliente;
  if cbxCliente.Text <> '' then
  begin
    btnCancelarPedido.Visible := False;
    with FCtrlCliente.Retorna(integer(cbxCliente.Items.Objects[cbxCliente.ItemIndex])) do
    begin
      edtCodigoCliente.Text := IntToStr(codigo);
      edtCidade.Text := cidade;
      edtUF.Text := uf;
    end;
  end
  else
  begin
    btnCancelarPedido.Visible := High(FLstItens.Itens) >= 0;
  end;
end;

procedure TfrmMain.cbxProdutoChange(Sender: TObject);
begin
  LimparProduto;
  if cbxProduto.Text <> '' then
  begin
    with FCtrlProduto.Retorna(integer(cbxProduto.Items.Objects[cbxProduto.ItemIndex])) do
    begin
      edtCodigoProduto.Text := IntToStr(codigo);
      edtQuantidade.Text := '1';
      edtValorUnitario.Text := FloatToStr(precovenda);
    end;
  end;
end;

procedure TfrmMain.DeletarItemLista;
var
  lNovaLista: IEntityLstPedidoItens;
  lSelecionado: integer;
begin
  lSelecionado := lvItens.ItemIndex;
  lNovaLista := TEntityLstPedidoItens.new;
  for var I := Low(FLstItens.Itens) to High(FLstItens.Itens) do
  begin
    if (lSelecionado <> I) then
    begin
      lNovaLista.AddItem(FLstItens.Itens[I]);
    end;
  end;
  lvItens.Items.Delete(lSelecionado);
  FLstItens.Itens := lNovaLista.Itens;
  ExibirBotaoCancelar;
  AtualizaTotal;
end;

procedure TfrmMain.EditandoItem(const pEmEdicao: Boolean);
begin
  if pEmEdicao then
    btnIncluirSalvar.Caption := 'Salvar'
  else
    btnIncluirSalvar.Caption := 'Incluir';

  cbxCliente.Enabled := not pEmEdicao;
  cbxProduto.Enabled := not pEmEdicao;
  btnEditarItem.Enabled := not pEmEdicao;
  btncancelarItem.Enabled := not pEmEdicao;
  btnCancelarPedido.Enabled := not pEmEdicao;
  btnSalvarPedido.Enabled := not pEmEdicao;
  lvItens.Enabled := not pEmEdicao;
end;

procedure TfrmMain.edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
begin
  Key := RetNumero(Key, edtValorUnitario.Text, True);
end;

procedure TfrmMain.ExibirBotaoCancelar;
begin
  btnCancelarPedido.Visible := (High(FLstItens.Itens) >= 0) and (cbxCliente.Text = '');
end;

procedure TfrmMain.FormAddProduto;
var
  lItem: TListItem;
  lPedItem: IEntityPedidoItem;
begin

  lPedItem := TEntityPedidoItem.new;

  lPedItem.codigoProduto := StrToInt(edtCodigoProduto.Text);
  lPedItem.quantidade := StrToInt(edtQuantidade.Text);
  lPedItem.valorUnitario := StrToFloat(edtValorUnitario.Text);

  FLstItens.AddItem(lPedItem);

  lItem := lvItens.Items.Add;
  lItem.Caption := edtCodigoProduto.Text;
  lItem.SubItems.Add(cbxProduto.Text);
  lItem.SubItems.Add(edtQuantidade.Text);
  lItem.SubItems.Add(edtValorUnitario.Text);
  lItem.SubItems.Add(FormatFloat('#,##0.00', StrToInt(edtQuantidade.Text) * StrToFloat(edtValorUnitario.Text)));

  AtualizaTotal;
  ExibirBotaoCancelar;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  lFrmPedido: TfrmVisualPedidos;
begin
  Inicializar;

  lFrmPedido := TfrmVisualPedidos.Create(Nil);
  lFrmPedido.putCtrlPedido(Self.FCtrlPedido);
  lFrmPedido.putCtrlCliente(Self.FCtrlCliente);
  lFrmPedido.Inicializar;
  lFrmPedido.Parent := tbsVisualizar;
  lFrmPedido.Align := alClient;
  lFrmPedido.Show;
end;

function TfrmMain.FormToEntity: IEntityPedido;
var
  lItem: IEntityPedidoItem;
begin
  Result := TEntityPedido.new;
  Result.codigoCliente := StrToInt(edtCodigoCliente.Text);
  for lItem in FLstItens.Itens do
  begin
    Result.Itens.AddItem(lItem);
  end;
end;

procedure TfrmMain.Inicializar;
var
  lConn: IConnection;
begin
  lConn := TFireDacConnection.new;
  FCtrlPedido := TCtrlPedido.new(lConn);
  FCtrlCliente := TCtrlCliente.new(lConn);
  FCtrlProduto := TCtrlProduto.new(lConn);
  LimparCliente;
  LimparProduto;
  PreencherComboCliente;
  PreencherComboProduto;
  FLstItens := TEntityLstPedidoItens.new;
end;

procedure TfrmMain.LimparCliente;
begin
  edtCodigoCliente.Text := '';
  edtCidade.Text := '';
  edtUF.Text := '';
end;

procedure TfrmMain.LimparProduto;
begin
  edtCodigoProduto.Text := '';
  edtQuantidade.Text := '0';
  edtValorUnitario.Text := '0';
end;

procedure TfrmMain.MsgWarning(const pTexto: String);
begin
  MessageDlg(pTexto, TMsgDlgType.mtWarning, [mbOk], 0);
end;

procedure TfrmMain.PreencherComboCliente;
begin
  cbxCliente.Items.Clear;
  cbxCliente.AddItem('', TObject(-1));
  for var lItem in FCtrlCliente.Listar.Itens do
  begin
    cbxCliente.AddItem(lItem.nome, TObject(lItem.codigo));
  end;
end;

procedure TfrmMain.PreencherComboProduto;
begin
  cbxProduto.Items.Clear;
  cbxProduto.AddItem('', TObject(-1));
  for var lItem in FCtrlProduto.Listar.Itens do
  begin
    cbxProduto.AddItem(lItem.descricao, TObject(lItem.codigo));
  end;
end;

procedure TfrmMain.PrepararFormAposFinalizar;
begin
  LimparProduto;
  LimparCliente;
  cbxCliente.ItemIndex := 0;
  cbxProduto.ItemIndex := 0;

  FLstItens := TEntityLstPedidoItens.new;
  lvItens.Clear;

  lblTotalRodape.Caption := FormatFloat('Valor Total: R$ #,##0.00', 0);
end;

function TfrmMain.RetNumero(Key: Char; Texto: string; EhDecimal: Boolean): Char;
begin
  if not EhDecimal then
  begin
    if not ( Key in ['0'..'9', Chr(8)] ) then
    begin
      Key := #0
    end;
  end
  else
  begin
    if Key = #46 then
    begin
      Key := FormatSettings.DecimalSeparator;
    end;

    if not (Key in ['0'..'9', Chr(8), FormatSettings.DecimalSeparator] ) then
    begin
      Key := #0
    end
    else
    if (Key = FormatSettings.DecimalSeparator ) and ( Pos( Key, Texto ) > 0 ) then
    begin
      Key := #0
    end;
  end;
  Result := Key;
end;

end.
