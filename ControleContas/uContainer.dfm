object Container: TContainer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 525
  Width = 608
  object SQLite: TFDConnection
    AfterConnect = SQLiteAfterConnect
    BeforeConnect = SQLiteBeforeConnect
    Left = 64
    Top = 56
  end
  object FDScript1: TFDScript
    SQLScripts = <
      item
        Name = 'Criar tabelas e triggers'
        SQL.Strings = (
          '/* Apagar table de Contatos se existir */'
          'DROP TABLE IF EXISTS Contatos;'
          ''
          '/*  table de Contatos se existir  */'
          ''
          'CREATE TABLE IF NOT EXISTS Contatos( '
          '                     ID INTEGER PRIMARY KEY AUTOINCREMENT,  '
          '                     Nome VARCHAR(100) NOT NULL,'
          '                     Documento VARCHAR(18) , '
          '                     Email VARCHAR(100), '
          '                     Telefone VARCHAR(18), '
          '                     TipoMovimento CHAR(1)'
          '                     );  '
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
            'ome) THEN RAISE (ABORT, "Documento j'#225' cadastrado! " )'
          '    END;'
          'END;'
          ''
          ''
          '/*********************** Categorias ************************/'
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
          '  ("PRESTA'#199#195'O DE SERVI'#199'O","R"),'
          '  ("SUPERMERCADO","D"),'
          '  ("FAST FOOD","D"),   '
          '  ("ASSINATURA","D"),'
          '  ("COMBUST'#205'VEL","D"),'
          '  ("EDUCA'#199#195'O","D"),'
          '  ("LAZER","D"),'
          '  ("MORADIA","D"),'
          '  ("SA'#218'DE","D"),'
          '  ("TRANSPORTE","D"),'
          '  ("VIAGEM","D"),    '
          '  ("VESTU'#193'RIO","D");'
          ''
          ''
          'CREATE TABLE IF NOT EXISTS SubCategorias( '
          '                     ID INTEGER PRIMARY KEY AUTOINCREMENT,  '
          '                     Descricao VARCHAR(100) NOT NULL,'
          '                     ID_Categoria INTEGER,'
          '                     TipoMovimento CHAR(1) );'
          #9#9#9#9#9' '
          'DROP TRIGGER IF EXISTS ValidarCategorias;'
          ''
          'CREATE TRIGGER IF NOT EXISTS ValidarSubCategorias'
          'BEFORE INSERT ON SubCategorias'
          'BEGIN '
          '  SELECT '
          '    CASE '
          
            #9'   WHEN (NEW.Descricao IS NULL) OR (New.Descricao = '#39#39') THEN RA' +
            'ISE (ABORT,"Informe uma descri'#231#227'o! ") '
          
            #9'   WHEN 0 < (SELECT COUNT(*) FROM SubCategorias WHERE Descricao' +
            ' = NEW.Descricao AND ID_Categoria = NEW.ID_Categoria  ) THEN RAI' +
            'SE (ABORT, "SubCategoria j'#225' cadastrada! " )'
          '    END;'
          'END; '
          ''
          ''
          '-- Contas '
          'CREATE TABLE IF NOT EXISTS Contas( '
          
            '                           ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
            '  '
          '                           Descricao VARCHAR(500),'
          '                           ID_Subcategoria INTEGER,'
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
          
            '      --  WHEN NEW.ID_Contato IS NULL THEN RAISE (ABORT,"Informe' +
            ' um contato ! ") '
          
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
          'END; '
          ''
          ''
          'CREATE TABLE IF NOT EXISTS Parcelas('
          
            '                           ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
            '  '
          '                           ID_Subcategoria INTEGER,'
          '                           ID_Conta INTEGER,'
          '                           ID_Categoria INTEGER,'
          '                           TipoMovimento CHAR(1), '
          '                           NParcela INT,'
          '                           Descricao VARCHAR(500),'
          '                           Valor FLOAT (15,2),'
          '                           ValorPago FLOAT (15,2),'
          '                           DataVencimento DATETIME,'
          '                           DataPagamento DATETIME, '
          '                           Observacoes TEXT);                  '
          ''
          #9#9#9#9#9#9'   '
          'DROP TRIGGER IF EXISTS GerarPrimeiraParcela;'
          'CREATE TRIGGER GerarPrimeiraParcela'
          '   AFTER INSERT ON Contas'
          '   BEGIN'
          
            '   INSERT INTO Parcelas(Descricao,ID_Subcategoria,NParcela,Valor' +
            ', DataVencimento,ID_Categoria,Observacoes,ID_Conta,TipoMovimento' +
            ') '
          
            '   VALUES (NEW.Descricao,New.ID_Subcategoria,1, NEW.Valor, Date(' +
            'NEW.DataVencimento),NEW.ID_Categoria,NEW.Observacoes,NEW.ID, NEW' +
            '.TipoMovimento);'
          'END;     '
          ''
          #9#9#9#9#9#9'   '
          'DROP TRIGGER IF EXISTS GerarParcelas;'
          'CREATE TRIGGER IF NOT EXISTS GerarParcelas'
          '   BEFORE INSERT ON Parcelas'
          
            '   WHEN NEW.NParcela <> (select NParcela from contas ORDER BY ID' +
            ' DESC LIMIT 1 ) BEGIN'
          '   INSERT INTO Parcelas(TipoMovimento,'
          '                        Descricao,'
          '                        ID_Subcategoria,'
          '                        ID_Conta,'
          '                        NParcela,'
          '                        Valor,'
          '                        DataVencimento,'
          '                        ID_Categoria,'
          '                        Observacoes)   '
          '                VALUES (NEW.TipoMovimento,'
          '                        NEW.Descricao,'
          '                        NEW.ID_Subcategoria,'
          '                        NEW.ID_Conta,'
          '                        NEW.NParcela + 1,'
          '                        NEW.Valor,'
          '                        Date(NEW.DataVencimento,"+1 month"),'
          '                        NEW.ID_Categoria,'
          '                        NEW.Observacoes'
          '                        );'
          'END;')
      end
      item
        Name = 'Inclus'#227'o de campos tabela contas'
        SQL.Strings = (
          ''
          'ALTER TABLE Contas ADD COLUMN ValorPago FLOAT (15,2);'
          'ALTER TABLE Contas ADD COLUMN DataPagamento DATETIME;'
          ''
          'DROP TRIGGER IF EXISTS GerarPrimeiraParcela;'
          'CREATE TRIGGER GerarPrimeiraParcela'
          '   AFTER INSERT ON Contas'
          '   BEGIN'
          
            '   INSERT INTO Parcelas(Descricao,ID_Subcategoria,NParcela,Valor' +
            ',DataPagamento, DataVencimento,ID_Categoria,Observacoes,ID_Conta' +
            ',TipoMovimento,ValorPago) '
          
            '   VALUES (NEW.Descricao,New.ID_Subcategoria,1, NEW.Valor, Date(' +
            'NEW.DataPagamento),Date(NEW.DataVencimento),NEW.ID_Categoria,NEW' +
            '.Observacoes,NEW.ID, NEW.TipoMovimento,NEW.ValorPago);'
          'END;     '
          ''
          #9#9#9#9#9#9'   '
          'DROP TRIGGER IF EXISTS GerarParcelas;'
          'CREATE TRIGGER IF NOT EXISTS GerarParcelas'
          '   BEFORE INSERT ON Parcelas'
          
            '   WHEN NEW.NParcela <> (select NParcela from contas ORDER BY ID' +
            ' DESC LIMIT 1 ) BEGIN'
          '   INSERT INTO Parcelas(TipoMovimento,'
          '                        Descricao,'
          '                        ID_Subcategoria,'
          '                        ID_Conta,'
          '                        NParcela,'
          '                        Valor,'
          '                        ValorPago,'
          '                        DataVencimento,'
          '                        DataPagamento,'
          '                        ID_Categoria,'
          '                        Observacoes)   '
          '                VALUES (NEW.TipoMovimento,'
          '                        NEW.Descricao,'
          '                        NEW.ID_Subcategoria,'
          '                        NEW.ID_Conta,'
          '                        NEW.NParcela + 1,'
          '                        NEW.Valor,'
          '                        NEW.ValorPago,                        '
          '                        Date(NEW.DataVencimento,"+1 month"),'
          '                        NEW.DataPagamento,'
          '                        NEW.ID_Categoria,'
          '                        NEW.Observacoes'
          '                        );'
          'END;')
      end>
    Connection = SQLite
    Params = <>
    Macros = <>
    Left = 160
    Top = 56
  end
  object tabCategorias: TFDQuery
    Connection = SQLite
    Left = 360
    Top = 208
  end
  object tabContas: TFDQuery
    Connection = SQLite
    Left = 352
    Top = 64
  end
  object tabLista: TFDQuery
    Connection = SQLite
    Left = 352
    Top = 136
  end
  object FDScript2: TFDScript
    SQLScripts = <
      item
        Name = 'tabLista'
        SQL.Strings = (
          'SELECT ID, Descricao Descricao_Parcela, '
          
            'SUM(Valor) ValorParcela, DataPagamento Pagamento, SUM(ValorPago)' +
            ' ValorPago,'
          'NParcela,'
          
            '(NParcela ||"/"||  (SELECT Count(*) FROM Parcelas P WHERE p.ID_C' +
            'onta = Parcelas.ID_Conta)) NParcelas,'
          ''
          'IIF(Descricao = "", '
          
            '      IIF((SELECT COALESCE(Descricao,"") FROM SUbCategorias WHER' +
            'E ID = Parcelas.ID_Subcategoria) IS NULL,(SELECT Descricao FROM ' +
            'Categorias WHERE ID = Parcelas.ID_Categoria), (SELECT Descricao ' +
            'FROM SubCategorias WHERE ID = Parcelas.ID_Subcategoria) )       ' +
            ' ,Descricao ) '
          '  Descricao, '
          
            '  (SELECT Descricao FROM Categorias WHERE ID = Parcelas.ID_Categ' +
            'oria) Categoria, '
          
            '  (SELECT Descricao FROM SubCategorias WHERE ID = Parcelas.ID_Su' +
            'bcategoria) SubCategoria,'
          '  strftime("%d/%m/%Y", DataVencimento) Vencimento, '
          '  Replace(printf("R$ %.2f",Valor),".",",") AS Valor,'
          'TipoMovimento,'
          
            'IIF(DataPagamento IS NOT NULL, "LIQUIDADA",IIF( strftime("%Y/%m/' +
            '%d", DataVencimento) < strftime("%Y/%m/%d", Datetime()), "ATRASA' +
            'DA", "ABERTA"))Status'
          ' FROM Parcelas '
          '  WHERE 1 = 1 ')
      end
      item
        Name = 'tabConsulta'
        SQL.Strings = (
          ''
          'SELECT'
          
            '(SELECT Replace(printf("R$ %.2f",SUM(Valor)),".",",") AS Valor F' +
            'ROM Parcelas WHERE TipoMovimento = "R" AND strftime("%Y-%m", Dat' +
            'aVencimento) = '#39'?'#39' ) Receitas,'
          
            '(SELECT Replace(printf("R$ %.2f",SUM(Valor)),".",",") AS Valor F' +
            'ROM Parcelas WHERE TipoMovimento = "D" AND strftime("%Y-%m", Dat' +
            'aVencimento) = '#39'?'#39') Despesas,'
          
            '(SELECT Replace(printf("R$ %.2f",SUM(Valor)),".",",") AS Valor F' +
            'ROM Parcelas WHERE TipoMovimento = "R" AND strftime("%Y-%m", Dat' +
            'aVencimento) = '#39'?'#39' AND  DataPagamento IS NOT NULL) Receber ,'
          
            '(SELECT Replace(printf("R$ %.2f",SUM(Valor)),".",",") AS Valor F' +
            'ROM Parcelas WHERE TipoMovimento = "D" AND strftime("%Y-%m", Dat' +
            'aVencimento) = '#39'?'#39' AND DataPagamento IS NOT NULL)  Pagar ')
      end>
    Connection = SQLite
    Params = <>
    Macros = <>
    Left = 184
    Top = 224
  end
  object tabConsulta: TFDQuery
    Connection = SQLite
    Left = 440
    Top = 64
  end
end
