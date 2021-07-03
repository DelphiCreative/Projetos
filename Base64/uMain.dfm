object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Cat'#225'logo de Produtos'
  ClientHeight = 455
  ClientWidth = 595
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 8
    Top = 14
    Width = 193
    Height = 184
  end
  object ImagemProduto: TImage
    Left = 10
    Top = 16
    Width = 189
    Height = 180
  end
  object SpeedButton1: TSpeedButton
    Left = 328
    Top = 192
    Width = 121
    Height = 25
    Caption = 'Incluir / Gravar'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 465
    Top = 192
    Width = 121
    Height = 25
    Caption = 'Excluir / Cancelar'
    OnClick = SpeedButton2Click
  end
  object Label1: TLabel
    Left = 222
    Top = 24
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object Label2: TLabel
    Left = 310
    Top = 24
    Width = 38
    Height = 13
    Caption = 'Produto'
  end
  object Label3: TLabel
    Left = 224
    Top = 65
    Width = 24
    Height = 13
    Caption = 'Valor'
  end
  object Label4: TLabel
    Left = 310
    Top = 65
    Width = 47
    Height = 13
    Caption = 'Categoria'
  end
  object Label5: TLabel
    Left = 224
    Top = 107
    Width = 46
    Height = 13
    Caption = 'Descri'#231#227'o'
  end
  object DBEdit1: TDBEdit
    Left = 222
    Top = 40
    Width = 81
    Height = 21
    DataField = '_id'
    DataSource = Container.ProdutosSource
    TabOrder = 0
    OnChange = DBEdit1Change
  end
  object DBEdit2: TDBEdit
    Left = 310
    Top = 40
    Width = 276
    Height = 21
    DataField = 'Produto'
    DataSource = Container.ProdutosSource
    TabOrder = 1
  end
  object DBRichEdit1: TDBRichEdit
    Left = 222
    Top = 123
    Width = 364
    Height = 57
    DataField = 'Descricao'
    DataSource = Container.ProdutosSource
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    TabOrder = 2
    Zoom = 100
  end
  object DBComboBox1: TDBComboBox
    Left = 310
    Top = 80
    Width = 277
    Height = 21
    DataField = 'Categoria'
    DataSource = Container.ProdutosSource
    Items.Strings = (
      'TESTE'
      'Teste 2')
    TabOrder = 3
  end
  object DBEdit3: TDBEdit
    Left = 223
    Top = 80
    Width = 81
    Height = 21
    DataField = 'Valor'
    DataSource = Container.ProdutosSource
    TabOrder = 4
  end
  object DBCheckBox1: TDBCheckBox
    Left = 222
    Top = 192
    Width = 97
    Height = 17
    Caption = 'Destaque'
    DataField = 'Destaque'
    DataSource = Container.ProdutosSource
    TabOrder = 5
  end
  object ProdutosGrid: TDBGrid
    Left = 8
    Top = 240
    Width = 579
    Height = 203
    DataSource = Container.ProdutosSource
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end
