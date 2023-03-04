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
  
SELECT 
  ID,
  Descricao, 
  CASE
     WHEN TipoMovimento = 'R' THEN 'RECEITA'
     WHEN TipoMovimento = 'D' THEN 'DESPESA'
  END Movimentacao  
FROM 
  Categorias