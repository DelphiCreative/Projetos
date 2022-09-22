object Container: TContainer
  OldCreateOrder = False
  Height = 367
  Width = 686
  object SQLite: TFDConnection
    AfterConnect = SQLiteAfterConnect
    BeforeConnect = SQLiteBeforeConnect
    Left = 136
    Top = 48
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 136
    Top = 112
  end
end
