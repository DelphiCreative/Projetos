object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Delphi com Google Sheets'
  ClientHeight = 299
  ClientWidth = 635
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
  object Button1: TButton
    Left = 32
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Get'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 136
    Top = 32
    Width = 433
    Height = 209
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 1
  end
  object Button2: TButton
    Left = 32
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Append'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 32
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 32
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 4
    OnClick = Button4Click
  end
end
