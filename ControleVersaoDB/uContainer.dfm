object Container: TContainer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 386
  Width = 646
  object SQLite: TFDConnection
    AfterConnect = SQLiteAfterConnect
    BeforeConnect = SQLiteBeforeConnect
    Left = 80
    Top = 48
  end
  object ScriptDB: TFDScript
    SQLScripts = <>
    Connection = SQLite
    Params = <>
    Macros = <>
    Left = 80
    Top = 106
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 80
    Top = 168
  end
end
