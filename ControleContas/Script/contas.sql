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

SELECT 
   strftime('%d/%m/%Y',DataVencimento) Vencimento,
   Replace(printf("R$ %.2f", Valor),'.',',') AS Valor  
 FROM contas;