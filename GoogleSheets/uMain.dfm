object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Integra'#231#227'o Delphi com Google Planilhas'
  ClientHeight = 624
  ClientWidth = 812
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    812
    624)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 30
    Width = 85
    Height = 16
    Caption = 'SpreadSheetId'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 511
    Top = 30
    Width = 33
    Height = 16
    Anchors = [akTop, akRight]
    Caption = 'Sheet'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitLeft = 504
  end
  object Label3: TLabel
    Left = 650
    Top = 30
    Width = 59
    Height = 16
    Anchors = [akTop, akRight]
    Caption = 'IndexStart'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitLeft = 643
  end
  object Label4: TLabel
    Left = 724
    Top = 30
    Width = 52
    Height = 16
    Anchors = [akTop, akRight]
    Caption = 'IndexEnd'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitLeft = 717
  end
  object Label5: TLabel
    Left = 33
    Top = 82
    Width = 16
    Height = 13
    Caption = 'List'
  end
  object Label6: TLabel
    Left = 647
    Top = 82
    Width = 59
    Height = 16
    Anchors = [akTop, akRight]
    Caption = 'IndexStart'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 719
    Top = 82
    Width = 52
    Height = 16
    Anchors = [akTop, akRight]
    Caption = 'IndexEnd'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 33
    Top = 205
    Width = 111
    Height = 13
    Caption = 'Retorno Google Sheets'
  end
  object edtSpreadSheetId: TEdit
    Left = 32
    Top = 49
    Width = 469
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = '1Ml7JxttVMEESORKfNwindhpmiZG1CNwdAYLSeKTBuok'
    TextHint = 'SpreedSheetId'
  end
  object edtSheet: TEdit
    Left = 511
    Top = 49
    Width = 134
    Height = 24
    Anchors = [akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = 'Pagina1'
    TextHint = 'Pagina1'
  end
  object edtStart: TEdit
    Left = 650
    Top = 49
    Width = 68
    Height = 24
    Anchors = [akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = 'A1'
    TextHint = 'A1'
  end
  object edtEnd: TEdit
    Left = 724
    Top = 49
    Width = 68
    Height = 24
    Anchors = [akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = 'F1'
    TextHint = 'F1'
  end
  object Button1: TButton
    Left = 234
    Top = 152
    Width = 134
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Get'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 374
    Top = 152
    Width = 134
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Append'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 514
    Top = 152
    Width = 134
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Update'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 652
    Top = 152
    Width = 143
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Clear'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = Button4Click
  end
  object Edit5: TEdit
    Left = 33
    Top = 101
    Width = 608
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    TextHint = 'SpreedSheetId'
  end
  object edtResult: TMemo
    Left = 33
    Top = 224
    Width = 760
    Height = 186
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object DBGrid1: TDBGrid
    Left = 32
    Top = 440
    Width = 761
    Height = 165
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button5: TButton
    Left = 32
    Top = 152
    Width = 176
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Conectar Google Planilhas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    OnClick = Button5Click
  end
  object Edit1: TEdit
    Left = 649
    Top = 101
    Width = 70
    Height = 24
    Anchors = [akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    Text = 'A1'
    TextHint = 'A1'
  end
  object Edit2: TEdit
    Left = 723
    Top = 101
    Width = 70
    Height = 24
    Anchors = [akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    Text = 'F1'
    TextHint = 'F1'
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 704
    Top = 280
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 368
    Top = 440
  end
end
