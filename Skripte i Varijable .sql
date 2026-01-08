GO
DECLARE @ime nvarchar(50)
SET @ime = 'Ana'

GO
DECLARE @prodano int
SET @prodano = (SELECT SUM(Kolicina) FROM Stavka)

GO
DECLARE @NazivProizvoda nvarchar(50)
		DECLARE @BojaProizvoda nvarchar(50)
		SELECT 
			@NazivProizvoda = p.Naziv,
			@BojaProizvoda = p.Boja
		FROM Proizvod AS p WHERE p.IDProizvod = 741

SELECT @NazivProizvoda
PRINT @BojaProizvoda
GO

