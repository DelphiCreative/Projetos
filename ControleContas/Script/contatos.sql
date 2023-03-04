DROP TABLE IF EXISTS Contatos;

CREATE TABLE IF NOT EXISTS Contatos( 
                     ID INTEGER PRIMARY KEY AUTOINCREMENT,  
                     Nome VARCHAR(100) NOT NULL,
                     Documento VARCHAR(18) , 
                     Email VARCHAR(100), 
                     Telefone VARCHAR(18), 
                     TipoMovimento CHAR(1)http
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

SELECT 
  ID,
  Nome, 
  CASE
     WHEN TipoMovimento = 'R' THEN 'RECEITA'
     WHEN TipoMovimento = 'D' THEN 'DESPESA'
  END Movimentacao  
FROM 
  Contatos;