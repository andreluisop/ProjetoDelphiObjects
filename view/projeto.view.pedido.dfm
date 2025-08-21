object frmVisualPedidos: TfrmVisualPedidos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsNone
  Caption = 'Visualizar Pedidos'
  ClientHeight = 560
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 600
    Height = 560
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlDados: TPanel
      Left = 0
      Top = 0
      Width = 585
      Height = 560
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object Label2: TLabel
        Left = 0
        Top = 73
        Width = 585
        Height = 20
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Pedidos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object pnlCabecalho: TPanel
        Left = 0
        Top = 247
        Width = 585
        Height = 20
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 0
          Top = 0
          Width = 585
          Height = 15
          Align = alTop
          Alignment = taCenter
          Caption = 'Itens do Pedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 86
        end
      end
      object lvItens: TListView
        Left = 0
        Top = 267
        Width = 585
        Height = 293
        Align = alClient
        Columns = <
          item
            Caption = 'C'#243'digo'
            Width = 80
          end
          item
            Caption = 'Descri'#231#227'o do Produto'
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
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
      end
      object lvPedidos: TListView
        Left = 0
        Top = 93
        Width = 585
        Height = 154
        Align = alTop
        Columns = <
          item
            Caption = 'Pedido'
            Width = 70
          end
          item
            Caption = 'Cliente'
            Width = 0
          end
          item
            Caption = 'Nome'
            Width = 300
          end
          item
            Caption = 'Data de Emiss'#227'o'
            Width = 100
          end
          item
            Caption = 'Valor Total'
            Width = 145
          end>
        ReadOnly = True
        RowSelect = True
        TabOrder = 2
        ViewStyle = vsReport
        OnChange = lvPedidosChange
      end
      object pnlSuperior: TPanel
        Left = 0
        Top = 0
        Width = 585
        Height = 73
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 3
        object lblFiltroCliente: TLabel
          Left = 3
          Top = 15
          Width = 104
          Height = 15
          Caption = 'Selecionar o Cliente'
        end
        object cbxCliente: TComboBox
          Left = 3
          Top = 34
          Width = 468
          Height = 23
          TabOrder = 0
        end
        object btnPesquisar: TButton
          Left = 484
          Top = 32
          Width = 93
          Height = 25
          Caption = 'Pesquisar'
          TabOrder = 1
          OnClick = btnPesquisarClick
        end
      end
    end
  end
end
