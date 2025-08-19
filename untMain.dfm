object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastros e Pesquisa de Pedidos'
  ClientHeight = 552
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pgcCtrlMain: TPageControl
    Left = 0
    Top = 0
    Width = 634
    Height = 552
    ActivePage = tbsPedidos
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object tbsPedidos: TTabSheet
      Caption = '&Cadastrar Pedidos'
      object pnlPrincipal: TPanel
        Left = 0
        Top = 0
        Width = 626
        Height = 522
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object pnlDados: TPanel
          Left = 0
          Top = 0
          Width = 626
          Height = 522
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object pnlCabecalho: TPanel
            Left = 0
            Top = 0
            Width = 626
            Height = 129
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object lblClienteNome: TLabel
              Left = 74
              Top = 21
              Width = 90
              Height = 15
              Caption = 'Nome do Cliente'
            end
            object lblClienteCidade: TLabel
              Left = 310
              Top = 21
              Width = 37
              Height = 15
              Caption = 'Cidade'
            end
            object lblClienteUF: TLabel
              Left = 520
              Top = 21
              Width = 35
              Height = 15
              Caption = 'Estado'
            end
            object lblProdutoQtd: TLabel
              Left = 312
              Top = 76
              Width = 62
              Height = 15
              Caption = 'Quantidade'
            end
            object lblProdutoDescricao: TLabel
              Left = 72
              Top = 76
              Width = 114
              Height = 15
              Caption = 'Descri'#231#227'o do Produto'
            end
            object lblProdutoValorUnit: TLabel
              Left = 409
              Top = 76
              Width = 71
              Height = 15
              Caption = 'Valor Unit'#225'rio'
            end
            object lblCodigoCliente: TLabel
              Left = 7
              Top = 21
              Width = 39
              Height = 15
              Caption = 'C'#243'digo'
            end
            object lblCodProduto: TLabel
              Left = 7
              Top = 76
              Width = 39
              Height = 15
              Caption = 'C'#243'digo'
            end
            object cbxCliente: TComboBox
              Left = 72
              Top = 38
              Width = 236
              Height = 23
              Style = csDropDownList
              TabOrder = 0
              OnChange = cbxClienteChange
            end
            object edtCidade: TEdit
              Left = 312
              Top = 38
              Width = 203
              Height = 23
              MaxLength = 64
              ReadOnly = True
              TabOrder = 1
            end
            object edtUF: TEdit
              Left = 520
              Top = 38
              Width = 48
              Height = 23
              MaxLength = 2
              ReadOnly = True
              TabOrder = 2
            end
            object edtQuantidade: TEdit
              Left = 312
              Top = 93
              Width = 90
              Height = 23
              NumbersOnly = True
              TabOrder = 3
              Text = '0'
            end
            object cbxProduto: TComboBox
              Left = 72
              Top = 93
              Width = 236
              Height = 23
              Style = csDropDownList
              TabOrder = 4
              OnChange = cbxProdutoChange
            end
            object edtValorUnitario: TMaskEdit
              Left = 409
              Top = 93
              Width = 89
              Height = 23
              TabOrder = 5
              Text = '0'
              OnKeyPress = edtValorUnitarioKeyPress
            end
            object btnIncluirSalvar: TButton
              Left = 510
              Top = 92
              Width = 66
              Height = 25
              Caption = 'Incluir'
              TabOrder = 6
              OnClick = btnIncluirSalvarClick
            end
            object edtCodigoCliente: TEdit
              Left = 7
              Top = 38
              Width = 60
              Height = 23
              Enabled = False
              ReadOnly = True
              TabOrder = 7
            end
            object edtCodigoProduto: TEdit
              Left = 7
              Top = 93
              Width = 60
              Height = 23
              Enabled = False
              NumbersOnly = True
              ReadOnly = True
              TabOrder = 8
            end
          end
          object lvItens: TListView
            Left = 0
            Top = 129
            Width = 626
            Height = 318
            Align = alClient
            BevelInner = bvNone
            Columns = <
              item
                Caption = 'C'#243'digo'
                Width = 80
              end
              item
                Caption = 'Descri'#231#227'o'
                Width = 200
              end
              item
                Caption = 'Quantidade'
                Width = 80
              end
              item
                Caption = 'Valor Unit'#225'rio'
                Width = 100
              end
              item
                Caption = 'Valor Total'
                Width = 100
              end>
            RowSelect = True
            TabOrder = 1
            ViewStyle = vsReport
          end
          object pnlRodape: TPanel
            Left = 0
            Top = 447
            Width = 626
            Height = 34
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 2
            object lblTotalRodape: TLabel
              Left = 0
              Top = 0
              Width = 626
              Height = 34
              Margins.Top = 12
              Align = alClient
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Valor Total: R$ 0,00'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              Layout = tlCenter
              ExplicitLeft = 3
              ExplicitTop = 8
              ExplicitWidth = 585
              ExplicitHeight = 23
            end
          end
          object pnlDireita: TPanel
            Left = 0
            Top = 481
            Width = 626
            Height = 41
            Align = alBottom
            BevelOuter = bvLowered
            TabOrder = 3
            object btnEditarItem: TButton
              AlignWithMargins = True
              Left = 40
              Top = 7
              Width = 110
              Height = 30
              Margins.Left = 5
              Margins.Right = 5
              Caption = 'Editar item'
              TabOrder = 0
              OnClick = btnEditarItemClick
            end
            object btncancelarItem: TButton
              AlignWithMargins = True
              Left = 173
              Top = 7
              Width = 110
              Height = 30
              Margins.Left = 5
              Margins.Top = 10
              Margins.Right = 5
              Caption = 'Cancelar Item'
              TabOrder = 1
              OnClick = btncancelarItemClick
            end
            object btnCancelarPedido: TButton
              AlignWithMargins = True
              Left = 440
              Top = 7
              Width = 110
              Height = 30
              Margins.Left = 5
              Margins.Right = 5
              Caption = 'Cancelar Pedido'
              TabOrder = 2
              Visible = False
              OnClick = btnCancelarPedidoClick
            end
            object btnSalvarPedido: TButton
              AlignWithMargins = True
              Left = 306
              Top = 7
              Width = 110
              Height = 30
              Margins.Left = 5
              Margins.Right = 5
              Margins.Bottom = 10
              Caption = 'Salvar Pedido'
              TabOrder = 3
              OnClick = btnSalvarPedidoClick
            end
          end
        end
      end
    end
    object tbsVisualizar: TTabSheet
      Caption = '&Visualizar Pedidos'
      ImageIndex = 1
    end
  end
end
