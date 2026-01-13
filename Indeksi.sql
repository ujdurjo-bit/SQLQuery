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




