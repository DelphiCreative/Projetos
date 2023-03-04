/* Apagar table de Contatos se existir */
DROP TABLE IF EXISTS Contatos;

/*  table de Contatos se existir  */

CREATE TABLE IF NOT EXISTS Contatos( 
                     ID INTEGER PRIMARY KEY AUTOINCREMENT,  
                     Nome VARCHAR(100) NOT NULL,
                     Documento VARCHAR(18) , 
                     Email VARCHAR(100), 
                     Telefone VARCHAR(18), 
                     TipoMovimento CHAR(1)
                     );  
  
DROP TRIGGER IF EXISTS ValidarContatos;

CREATE TRIGGER IF NOT EXISTS ValidarContatos
BEFORE INSERT ON Contatos 
BEGIN 
  SELECT 
    CASE
      WHEN (NEW.Nome IS NULL) OR (New.Nome = '') THEN RAISE (ABORT,"Informe Nome! ") 
      WHEN 0 < (SELECT COUNT(*) FROM Contatos WHERE Nome = NEW.Nome) THEN RAISE (ABORT, "Documento já cadastrado! " )
    END;
END;

INSERT INTO Contatos 
  (Nome,TipoMovimento) 
VALUES 
  ("TRABALHO","R"),
  ("NETFLIX","D")



/*********************** Categorias ************************/
CREATE TABLE IF NOT EXISTS Categorias( 
                     ID INTEGER PRIMARY KEY AUTOINCREMENT,  
                     Descricao VARCHAR(100) NOT NULL,
                     TipoMovimento CHAR(1) );
					 
DROP TRIGGER IF EXISTS ValidarCategorias;

CREATE TRIGGER IF NOT EXISTS ValidarCategorias
BEFORE INSERT ON Categorias
BEGIN 
  SELECT 
    CASE 
	   WHEN (NEW.Descricao IS NULL) OR (New.Descricao = '') THEN RAISE (ABORT,"Informe uma descrição! ") 
	   WHEN 0 < (SELECT COUNT(*) FROM Categorias WHERE Descricao = NEW.Descricao) THEN RAISE (ABORT, "Categoria já cadastrada! " )
    END;
END; 

INSERT INTO Categorias 
  (Descricao,TipoMovimento) 
VALUES 
  ("SALÁRIO","R"),
  ("ALIMENTAÇÃO","D"),
  ("ASSINATURA","D"),
  ("COMBUSTÍVEL","D"),
  ("EDUCAÇÃO","D"),
  ("LAZER","D"),
  ("MORADIA","D"),
  ("SAÚDE","D"),
  ("TRANSPORTE","D"), 
  ("VESTUÁRIO","D");
  

-- Contas 
CREATE TABLE IF NOT EXISTS Contas( 
                           ID INTEGER PRIMARY KEY AUTOINCREMENT,  
                           ID_Contato INTEGER,
                           NParcela INT,
                           Valor FLOAT (15,2),
                           TipoMovimento CHAR(1), 
                           DataVencimento DATETIME,
                           ID_Categoria INTEGER,
                           Observacoes TEXT);				 
					 
					 
CREATE TRIGGER IF NOT EXISTS ValidarContas
BEFORE INSERT ON Contas 
BEGIN 
  SELECT 
    CASE 
      WHEN NEW.ID_Contato IS NULL THEN RAISE (ABORT,"Informe um contato ! ") 
      WHEN NEW.NParcela IS NULL OR NEW.NParcela = 0 THEN RAISE (ABORT,"Informe o número de parcelas") 
      WHEN NEW.Valor IS NULL OR NEW.Valor = 0 THEN RAISE (ABORT,"Informe o valor da parcela") 
      WHEN NEW.DataVencimento IS NULL THEN RAISE (ABORT,"Informe o 1º vencimento")
      WHEN NEW.TipoMovimento IS NULL THEN RAISE (ABORT,"Informe o tipo de movimento")
      WHEN NEW.ID_Categoria IS NULL THEN RAISE (ABORT,"Informe uma categoria ! ") 
    END;
END; 

INSERT INTO Contas
  (
    ID_Contato,
    NParcela,
    Valor,
    DataVencimento, 
    TipoMovimento,
    ID_Categoria 
  )  
VALUES
  (
     (SELECT ID FROM Contatos WHERE Nome = "TRABALHO"),
     12,
     2000.50,
     '2021-01-06',
     (SELECT ID FROM Categorias WHERE Descricao = "SALÁRIO"),
     (SELECT TipoMovimento FROM Categorias WHERE Descricao = "SALÁRIO")
  )  
,
  (
     (SELECT ID FROM Contatos WHERE Nome = "NETFLIX"),
     12,
     39.50,
     '2021-01-06',
     (SELECT ID FROM Categorias WHERE Descricao = "ASSINATURA"),
     (SELECT TipoMovimento FROM Categorias WHERE Descricao = "ASSINATURA")
  );



CREATE TABLE IF NOT EXISTS Parcelas(
                           ID INTEGER PRIMARY KEY AUTOINCREMENT,  
                           ID_Contato INTEGER,
                           ID_Conta INTEGER,
                           NParcela INT,
                           Valor FLOAT (15,2),
                           ValorPago FLOAT (15,2),
                           DataVencimento DATETIME,
                           DataPagamento DATETIME, 
                           ID_Categoria INTEGER,
                           Observacoes TEXT);                  

						   
DROP TRIGGER IF EXISTS GerarPrimeiraParcela;
CREATE TRIGGER GerarPrimeiraParcela
   AFTER INSERT ON Contas
   BEGIN
   INSERT INTO Parcelas(ID_Contato,NParcela,Valor,DataVencimento,ID_Categoria,Observacoes,ID_Conta) 
   VALUES (New.ID_Contato,1,NEw.Valor,New.DataVencimento,NEW.ID_Categoria,NEW.Observacoes,NEW.ID);
END;      

						   
DROP TRIGGER IF EXISTS GerarParcelas;
CREATE TRIGGER IF NOT EXISTS GerarParcelas
   BEFORE INSERT ON Parcelas
   WHEN NEW.NParcela <> (select NParcela from contas ORDER BY ID DESC LIMIT 1 ) BEGIN
   INSERT INTO Parcelas(ID_Contato,
                        ID_Conta,
                        NParcela,
                        Valor,
                        DataVencimento,
                        ID_Categoria,
                        Observacoes)   
                VALUES (NEW.ID_Contato,
                        NEW.ID_Conta,
                        NEW.NParcela + 1,
                        NEW.Valor,
                        Date(NEW.DataVencimento,"+1 month"),
                        NEW.ID_Categoria,
                        NEW.Observacoes
                        );
END;


