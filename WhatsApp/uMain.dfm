object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 476
  ClientWidth = 544
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 33
    Height = 13
    Caption = 'Codigo'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 27
    Height = 13
    Caption = 'Nome'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 16
    Top = 96
    Width = 42
    Height = 13
    Caption = 'Telefone'
    FocusControl = DBEdit3
  end
  object Label4: TLabel
    Left = 16
    Top = 136
    Width = 51
    Height = 13
    Caption = 'Mensagem'
    FocusControl = DBMemo1
  end
  object DBEdit1: TDBEdit
    Left = 16
    Top = 32
    Width = 134
    Height = 21
    DataField = 'Codigo'
    DataSource = DataSource1
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 16
    Top = 72
    Width = 250
    Height = 21
    DataField = 'Nome'
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBEdit3: TDBEdit
    Left = 16
    Top = 112
    Width = 250
    Height = 21
    DataField = 'Telefone'
    DataSource = DataSource1
    TabOrder = 2
  end
  object DBMemo1: TDBMemo
    Left = 16
    Top = 152
    Width = 250
    Height = 89
    DataField = 'Mensagem'
    DataSource = DataSource1
    TabOrder = 3
  end
  object DBNavigator1: TDBNavigator
    Left = 16
    Top = 247
    Width = 250
    Height = 25
    DataSource = DataSource1
    TabOrder = 4
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 278
    Width = 513
    Height = 171
    DataSource = DataSource1
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 408
    Top = 247
    Width = 121
    Height = 25
    Caption = 'Enviar Mensagens'
    TabOrder = 6
    OnClick = Button1Click
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\MeusProjetos\GitHub\Projetos\WhatsApp\Win64\Debug\me' +
        'nsagem.db'
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = FDConnection1AfterConnect
    Left = 64
    Top = 24
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM Mensagens')
    Left = 64
    Top = 80
    object FDQuery1Codigo: TFDAutoIncField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery1Nome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Size = 50
    end
    object FDQuery1Telefone: TStringField
      FieldName = 'Telefone'
      Origin = 'Telefone'
      Size = 14
    end
    object FDQuery1Mensagem: TWideMemoField
      FieldName = 'Mensagem'
      Origin = 'Mensagem'
      BlobType = ftWideMemo
    end
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 280
    Top = 240
  end
end
