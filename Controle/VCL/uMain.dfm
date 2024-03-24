object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Controle'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  OnCreate = FormCreate
  TextHeight = 15
  object MainMenu1: TMainMenu
    Left = 328
    Top = 80
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Clientes1: TMenuItem
        Caption = 'Clientes'
      end
      object Produtos1: TMenuItem
        Caption = 'Produtos'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Categorias1: TMenuItem
        Caption = 'Categorias'
      end
      object Subcategorias1: TMenuItem
        Caption = 'Subcategorias'
      end
    end
    object Movimentao1: TMenuItem
      Caption = 'Movimenta'#231#227'o'
      object Compras1: TMenuItem
        Caption = 'Compras'
      end
      object Vendas1: TMenuItem
        Caption = 'Vendas'
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
      object Clientes2: TMenuItem
        Caption = 'Clientes'
      end
      object Produtos2: TMenuItem
        Caption = 'Produtos'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Vendas2: TMenuItem
        Caption = 'Vendas'
      end
      object Compras2: TMenuItem
        Caption = 'Compras'
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object N4: TMenuItem
        Caption = 'Estoque'
      end
    end
  end
  object FDConnection: TFDConnection
    Left = 328
    Top = 160
  end
end
