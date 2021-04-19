object Container: TContainer
  OldCreateOrder = False
  Height = 179
  Width = 417
  object SQLite: TFDConnection
    LoginPrompt = False
    AfterConnect = SQLiteAfterConnect
    BeforeConnect = SQLiteBeforeConnect
    Left = 72
    Top = 40
  end
  object SQLiteDriver: TFDPhysSQLiteDriverLink
    Left = 72
    Top = 96
  end
  object ProdutosSource: TDataSource
    DataSet = Produtos
    Left = 184
    Top = 96
  end
  object Produtos: TFDQuery
    BeforeInsert = ProdutosBeforeInsert
    Connection = SQLite
    Left = 184
    Top = 40
  end
  object CategoriasSource: TDataSource
    DataSet = Categorias
    Left = 288
    Top = 96
  end
  object Categorias: TFDQuery
    Connection = SQLite
    Left = 288
    Top = 40
  end
end
