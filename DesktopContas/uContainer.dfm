object Container: TContainer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 472
  Width = 713
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 288
    Top = 48
  end
  object FDScript1: TFDScript
    SQLScripts = <
      item
        Name = 'Contatos'
        SQL.Strings = (
          'CREATE TABLE IF NOT EXISTS Contatos( '
          '                     ID INTEGER PRIMARY KEY AUTOINCREMENT,  '
          '                     Nome VARCHAR(100) NOT NULL,'
          '                     TipoMovimento CHAR(1) NOT NULL'
          '                     );  '
          '                     '
          '  '
          'DROP TRIGGER IF EXISTS ValidarContatos;'
          ''
          'CREATE TRIGGER IF NOT EXISTS ValidarContatos'
          'BEFORE INSERT ON Contatos '
          'BEGIN '
          '  SELECT '
          '    CASE'
          
            '      WHEN (NEW.Nome IS NULL) OR (New.Nome = '#39#39') THEN RAISE (ABO' +
            'RT,"Informe Nome! ") '
          
            '      WHEN 0 < (SELECT COUNT(*) FROM Contatos WHERE Nome = NEW.N' +
            'ome) THEN RAISE (ABORT, "Contato j'#225' cadastrado! " )'
          
            '      WHEN (NEW.TipoMovimento IS NULL) OR (New.TipoMovimento = '#39 +
            #39') THEN RAISE (ABORT,"Informe Tipo de movimento! ") '
          '    END;'
          'END;'
          ''
          'INSERT INTO Contatos '
          '  (Nome,TipoMovimento) '
          'VALUES '
          '  ("TRABALHO","R"),'
          '  ("NETFLIX","D");')
      end
      item
        Name = 'Categorias'
        SQL.Strings = (
          'CREATE TABLE IF NOT EXISTS Categorias( '
          '                     ID INTEGER PRIMARY KEY AUTOINCREMENT,  '
          '                     Descricao VARCHAR(100) NOT NULL,'
          '                     TipoMovimento CHAR(1) );'
          #9#9#9#9#9' '
          'DROP TRIGGER IF EXISTS ValidarCategorias;'
          ''
          'CREATE TRIGGER IF NOT EXISTS ValidarCategorias'
          'BEFORE INSERT ON Categorias'
          'BEGIN '
          '  SELECT '
          '    CASE '
          
            #9'   WHEN (NEW.Descricao IS NULL) OR (New.Descricao = '#39#39') THEN RA' +
            'ISE (ABORT,"Informe uma descri'#231#227'o! ") '
          
            #9'   WHEN 0 < (SELECT COUNT(*) FROM Categorias WHERE Descricao = ' +
            'NEW.Descricao) THEN RAISE (ABORT, "Categoria j'#225' cadastrada! " )'
          '    END;'
          'END; '
          ''
          'INSERT INTO Categorias '
          '  (Descricao,TipoMovimento) '
          'VALUES '
          '  ("SAL'#193'RIO","R"),'
          '  ("ALIMENTA'#199#195'O","D"),'
          '  ("ASSINATURA","D"),'
          '  ("COMBUST'#205'VEL","D"),'
          '  ("EDUCA'#199#195'O","D"),'
          '  ("LAZER","D"),'
          '  ("MORADIA","D"),'
          '  ("SA'#218'DE","D"),'
          '  ("TRANSPORTE","D"), '
          '  ("VESTU'#193'RIO","D");'
          '  ')
      end
      item
        Name = 'Contas'
        SQL.Strings = (
          'CREATE TABLE IF NOT EXISTS Contas( '
          
            '                           ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
            '  '
          '                           ID_Contato INTEGER,'
          '                           NParcela INT,'
          '                           Valor FLOAT (15,2),'
          '                           TipoMovimento CHAR(1), '
          '                           DataVencimento DATETIME,'
          '                           ID_Categoria INTEGER,'
          '                           Observacoes TEXT);'#9#9#9#9' '
          #9#9#9#9#9' '
          #9#9#9#9#9' '
          'CREATE TRIGGER IF NOT EXISTS ValidarContas'
          'BEFORE INSERT ON Contas '
          'BEGIN '
          '  SELECT '
          '    CASE '
          
            '      WHEN NEW.ID_Contato IS NULL THEN RAISE (ABORT,"Informe um ' +
            'contato ! ") '
          
            '      WHEN NEW.NParcela IS NULL OR NEW.NParcela = 0 THEN RAISE (' +
            'ABORT,"Informe o n'#250'mero de parcelas") '
          
            '      WHEN NEW.Valor IS NULL OR NEW.Valor = 0 THEN RAISE (ABORT,' +
            '"Informe o valor da parcela") '
          
            '      WHEN NEW.DataVencimento IS NULL THEN RAISE (ABORT,"Informe' +
            ' o 1'#186' vencimento")'
          
            '      WHEN NEW.TipoMovimento IS NULL THEN RAISE (ABORT,"Informe ' +
            'o tipo de movimento")'
          
            '      WHEN NEW.ID_Categoria IS NULL THEN RAISE (ABORT,"Informe u' +
            'ma categoria ! ") '
          '    END;'
          'END; '#9#9#9#9#9#9'   '
          ''
          ''
          'DROP TRIGGER IF EXISTS GerarPrimeiraParcela;'
          'CREATE TRIGGER GerarPrimeiraParcela'
          '   AFTER INSERT ON Contas'
          '   BEGIN'
          
            '   INSERT INTO Parcelas(ID_Contato,NParcela,Valor, DataVenciment' +
            'o,ID_Categoria,Observacoes,ID_Conta) '
          
            '   VALUES (New.ID_Contato,1,NEw.Valor,  Date(NEW.DataVencimento,' +
            '"-1 month"),NEW.ID_Categoria,NEW.Observacoes,NEW.ID);'
          'END;     ')
      end
      item
        Name = 'Parcelas'
        SQL.Strings = (
          'CREATE TABLE IF NOT EXISTS Parcelas('
          
            '                           ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
            '  '
          '                           ID_Contato INTEGER,'
          '                           ID_Conta INTEGER,'
          '                           NParcela INT,'
          '                           Valor FLOAT (15,2),'
          '                           ValorPago FLOAT (15,2),'
          '                           DataVencimento DATETIME,'
          '                           DataPagamento DATETIME, '
          '                           ID_Categoria INTEGER,'
          '                           Observacoes TEXT);                  '
          ''
          'DROP TRIGGER IF EXISTS GerarParcelas;'
          'CREATE TRIGGER IF NOT EXISTS GerarParcelas'
          '   BEFORE INSERT ON Parcelas'
          
            '   WHEN NEW.NParcela <> (select NParcela from contas ORDER BY ID' +
            ' DESC LIMIT 1 ) BEGIN'
          '   INSERT INTO Parcelas(ID_Contato,'
          '                        ID_Conta,'
          '                        NParcela,'
          '                        Valor,'
          '                        DataVencimento,'
          '                        ID_Categoria,'
          '                        Observacoes)   '
          '                VALUES (NEW.ID_Contato,'
          '                        NEW.ID_Conta,'
          '                        NEW.NParcela + 1,'
          '                        NEW.Valor,'
          '                        Date(NEW.DataVencimento,"+1 month"),'
          '                        NEW.ID_Categoria,'
          '                        NEW.Observacoes'
          '                        );'
          'END;'
          '')
      end
      item
        Name = 'Insert contas'
        SQL.Strings = (
          'INSERT INTO Contas'
          '  ('
          '    ID_Contato,'
          '    NParcela,'
          '    Valor,'
          '    DataVencimento, '
          '    TipoMovimento,'
          '    ID_Categoria '
          '  )  '
          'VALUES'
          '  ('
          '     (SELECT ID FROM Contatos WHERE Nome = "TRABALHO"),'
          '     12,'
          '     2000.50,'
          '     '#39'2022-02-06'#39','
          '     (SELECT ID FROM Categorias WHERE Descricao = "SAL'#193'RIO"),'
          
            '     (SELECT TipoMovimento FROM Categorias WHERE Descricao = "SA' +
            'L'#193'RIO")'
          '  )  '
          ','
          '  ('
          '     (SELECT ID FROM Contatos WHERE Nome = "NETFLIX"),'
          '     12,'
          '     39.50,'
          '     '#39'2022-01-06'#39','
          '     (SELECT ID FROM Categorias WHERE Descricao = "ASSINATURA"),'
          
            '     (SELECT TipoMovimento FROM Categorias WHERE Descricao = "AS' +
            'SINATURA")'
          '  );'
          '  '
          '    '
          '')
      end>
    Connection = SQLite
    Params = <>
    Macros = <>
    Left = 176
    Top = 48
  end
  object SQLite: TFDConnection
    AfterConnect = SQLiteAfterConnect
    BeforeConnect = SQLiteBeforeConnect
    Left = 80
    Top = 48
  end
end
