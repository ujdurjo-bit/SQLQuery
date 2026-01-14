/*Optimizirajte upit: SELECT DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' 
Koliko stranica je pregledao RDBMS?
Napravite indeks koji optimizira upit
Koliko sad stranica pregled RDBMS?
Uklonite indeks
*/

GO         
SET STATISTICS IO ON;  
GO  
SELECT DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'
GO  
SET STATISTICS IO OFF;  
GO 

CREATE NONCLUSTERED INDEX IX_Racun_DatumIzdavanja ON Racun(DatumIzdavanja)

DROP INDEX IX_Racun_DatumIzdavanja ON Racun





--TRANSAKCIJE
/*1.Napravite tablicu Osoba. Pokrenite transakciju i umetnite 3 zapisa u Osoba. Probajte dohvatiti podatke iz tablice. 
Odustanite od transakcije. Probajte dohvatiti podatke iz tablice. */


CREATE TABLE Osoba (
IDOsobe int PRIMARY KEY IDENTITY,
Ime nvarchar(25),
Prezime nvarchar(35)
);


BEGIN TRAN

INSERT INTO Osoba VALUES ('Iva', 'Ivić');
INSERT INTO Osoba VALUES ('Marko', 'Marić');
INSERT INTO Osoba VALUES ('Perica', 'Novi');

PRINT 'Podaci unutar transakcije'
SELECT * FROM Osoba

ROLLBACK

PRINT 'Podaci nakon transakcije'
SELECT * FROM Osoba

--2.Riješite zadatak 1, ali umjesto odustajanja potvrdite transakciju.

BEGIN TRAN

INSERT INTO Osoba VALUES ('Iva', 'Ivić');
INSERT INTO Osoba VALUES ('Marko', 'Marić');
INSERT INTO Osoba VALUES ('Perica', 'Novi');

PRINT 'Podaci unutar transakcije'
SELECT * FROM Osoba

COMMIT

PRINT 'Podaci nakon transakcije'
SELECT * FROM Osoba

--3.U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu točku. Umetnite još 1 zapis. Na kraju odustanite od transakcije. Što je u tablici?
BEGIN TRAN

INSERT INTO Osoba VALUES ('Niko', 'Nozić');

SAVE TRANSACTION KontrolnaTocka

INSERT INTO Osoba VALUES ('Marija', 'Marić');

SELECT * FROM Osoba

ROLLBACK KontrolnaTocka

SELECT * FROM Osoba



--4.U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu točku. Umetnite još 1 zapis. Na kraju potvrdite transakciju. Što je u tablici?
BEGIN TRAN

INSERT INTO Osoba VALUES ('Niko', 'Nozić');

SAVE TRANSACTION KontrolnaTocka

INSERT INTO Osoba VALUES ('Marija', 'Marić');

SELECT * FROM Osoba

COMMIT

SELECT * FROM Osoba



--U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu točku. Umetnite još 1 zapis i vratite se na kontrolnu točku. Na kraju odustanite od transakcije.

BEGIN TRAN

INSERT INTO Osoba VALUES ('Josip', 'Ujdur');

PRINT 'Podaci nakon transakcije'
SELECT * FROM Osoba

SAVE TRANSACTION KontrolnaTocka

INSERT INTO Osoba VALUES ('John', 'Smith');

ROLLBACK

PRINT 'Podaci nakon transakcije'
SELECT * FROM Osoba




--U transakciji umetnite 1 zapis u Osoba i postavite kontrolnu točku. ,Umetnite još 1 zapis i vratite se na kontrolnu točku. Na kraju potvrdite transakciju.

BEGIN TRAN

INSERT INTO Osoba VALUES ('Josip', 'Ujdur');

PRINT 'Podaci nakon transakcije'
SELECT * FROM Osoba

SAVE TRANSACTION KontrolnaTocka

INSERT INTO Osoba VALUES ('John', 'Smith');

ROLLBACK

PRINT 'Podaci nakon transakcije'
SELECT * FROM Osoba

COMMIT




DELETE FROM Osoba
DBCC CHECKIDENT ('Osoba', RESEED, 0);

PRINT @@TRANCOUNT

BEGIN TRAN

INSERT INTO Osoba VALUES ('Niko', 'Nozić');
PRINT @@ROWCOUNT
SAVE TRANSACTION KontrolnaTocka
PRINT @@ROWCOUNT
INSERT INTO Osoba VALUES ('Marija', 'Marić');

SELECT * FROM Osoba
PRINT @@ROWCOUNT
ROLLBACK

SELECT * FROM Osoba


/* 9. Napišite proceduru za brisanje proizvoda. Neka procedura prima 1 parametar, IDProizvod. Transakciju vodite izvan procedure. Ispišite uspjeh ili neuspjeh. 
Pozovite 3 puta proceduru s vrijednostima parametara jednakim 1001, 1002 i 1003. 
Pozovite 3 puta proceduru s vrijednostima parametara jednakim 1001, 1002 i 777.
*/

GO
CREATE PROC ObrisiProizvod @IDProizvod INT
AS
BEGIN 
	BEGIN TRY
		DELETE FROM Proizvod WHERE IDProizvod= @IDProizvod;
			IF @@ROWCOUNT = 0
				PRINT 'PRoizvod s ID-em' + CAST(@IDProizvod AS nvarchar) + 'ne postoji'
			ELSE 
				PRINT 'Uspješno obrisan proizvod s ID-em:' + CAST(@IDProizvod AS nvarchar)
	END TRY
	BEGIN CATCH
		PRINT 'Greška pri brisanju proizvoda s ID-em:' + CAST(@IDProizvod AS nvarchar)

	END CATCH


END

GO
BEGIN TRAN
	BEGIN TRY
		EXEC ObrisiProizvod @IDProizvod = 1001;
		EXEC ObrisiProizvod @IDProizvod = 1002;
		EXEC ObrisiProizvod @IDProizvod = 1003;
		COMMIT
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
				ROLLBACK
			END CATCH
END


--DZ: Optimizirajte upit: SELECT IDRacun, DatumIzdavanja FROM Racun WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59' 
GO         
SET STATISTICS IO ON;  
SELECT IDRacun, DatumIzdavanja 
FROM Racun 
WHERE DatumIzdavanja BETWEEN '20010702' AND '20010702 23:59:59'
GO         
SET STATISTICS IO OFF  

CREATE NONCLUSTERED INDEX IX_DatumIzdavanja ON Racun(DatumIzdavanja)

DROP INDEX IX_DatumIzdavanja ON Racun



/*Osigurajte da u tablici Drzava ne mogu postojati dvije države s istim nazivom. 
Napišite proceduru koja prima 1 XML parametar koji sadržava podatke potrebne za umetnuti novu državu i tri njena grada. Transakciju vodite unutar procedure. Ispišite uspjeh ili neuspjeh. 
Pozovite proceduru 2 puta s istim XML dokumentom kao parametrom.*/

GO
CREATE PROCEDURE DodajDrzavuIGradove
    @InputXML XML
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @NazivDrzave NVARCHAR(100);
        DECLARE @IDDrzava INT;

        
        SET @NazivDrzave = @InputXML.value('(/podaci/drzava)[1]', 'NVARCHAR(100)');

      
        INSERT INTO Drzava (Naziv)
        VALUES (@NazivDrzave);

        SET @IDDrzava = SCOPE_IDENTITY();

        
        INSERT INTO Grad (Naziv, DrzavaID)
        SELECT
            x.value('.', 'NVARCHAR(100)'),
            @IDDrzava
        FROM @InputXML.nodes('/podaci/grad') AS T(x);

        COMMIT;
        PRINT 'Uspjeh: Država i gradovi su umetnuti.';
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Neuspjeh: Došlo je do greške.';
    END CATCH
END;


DECLARE @xml XML = '
<podaci>
    <drzava>Hrvatska</drzava>
    <grad>MAlino</grad>
    <grad>Vž</grad>
    <grad>Daruvar</grad>
</podaci>';

EXEC DodajDrzavuIGradove @InputXML = @xml;
EXEC DodajDrzavuIGradove @InputXML = @xml;

GO




/*
Unutar vanjske transakcije pozovite prethodnu proceduru s nekim drugim parametrom. 
Nakon toga odustanite od vanjske transakcije. Ispišite uspjeh ili neuspjeh. 
Je li umetanje napravljeno?

*/

GO

DECLARE @xml2 XML = '
<podaci>
    <drzava>Srbija</drzava>
    <grad>Beograd</grad>
    <grad>Novi Sad</grad>
    <grad>Niš</grad>
</podaci>';

BEGIN TRANSACTION;

BEGIN TRY
    
    EXEC DodajDrzavuIGradove @InputXML = @xml2;
    
    ROLLBACK;

    PRINT 'Neuspjeh: Vanjska transakcija je odustala.';
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Neuspjeh: Došlo je do greške u vanjskoj transakciji.';
END CATCH;
