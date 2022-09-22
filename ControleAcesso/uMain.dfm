object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Controle de acesso'
  ClientHeight = 265
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 96
    Top = 45
    Width = 33
    Height = 13
    Caption = 'Cliente'
  end
  object edtID: TEdit
    Left = 96
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 96
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Verificar'
    TabOrder = 1
    OnClick = Button1Click
  end
end
