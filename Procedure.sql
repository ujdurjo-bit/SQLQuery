/*Napišite proceduru koja dohvaća sve retke iz tablice Kupac.
Pozovite proceduru. Promijenite proceduru tako da vraća rezultate poredane po
imenu pa po prezimenu. Uklonite proceduru.*/
GO
CREATE PROC DohvatiKupce
AS
BEGIN
	SELECT * FROM Kupac;	

END

GO
--Pozovite proceduru
EXEC DohvatiKupce

--Promijenite proceduru tako da vraća rezultate poredane po imenu pa po prezimenu.
GO
ALTER PROC DohvatiKupce
AS
BEGIN
	SELECT * FROM Kupac ORDER BY Ime, Prezime;

END

EXEC DohvatiKupce

--Uklonite proceduru.
DROP PROCEDURE DohvatiKupce


/*Napišite proceduru koja dohvaća prvih 10 redaka iz tablice Proizvod, prvih 5
redaka iz tablice KreditnaKartica i zadnja 3 retka iz tablice Racun. Pozovite
proceduru. Uklonite proceduru.*/

GO
CREATE PROC Dohvat
AS
BEGIN
	SELECT TOP 10 * FROM Proizvod;
	SELECT TOP 5 * FROM KreditnaKartica;
	SELECT TOP 3 * FROM Racun ORDER BY IDRacun DESC;
END

GO
--Pozovite proceduru
EXEC Dohvat

--Uklonite proceduru
DROP PROCEDURE Dohvat


/*Napišite proceduru koja prima @ID proizvoda i vraća samo taj proizvod iz tablice Proizvod.
Pozovite proceduru na oba načina. Uklonite proceduru.*/

GO
CREATE PROC DohvatiProizvodPoID 
		@ID INT
AS
BEGIN
	SELECT * FROM Proizvod WHERE IDProizvod = @ID;	

END

GO
--Pozovite proceduru
--Bitan redoslijed
EXEC DohvatiProizvodPoID 1

--Nije Bitan redoslijed
GO
EXEC DohvatiProizvodPoID @ID = 1
--Uklonite proceduru
DROP PROCEDURE DohvatiProizvodPoID 1

--4. Napišite proceduru koja prima dvije cijene i vraća nazive i cijene svih proizvoda čija cijena je u zadanom rasponu. Pozovite proceduru na oba načina. Uklonite proceduru.

--5. Napišite proceduru koja prima četiri parametra potrebna za unos nove kreditne kartice. Neka procedura napravi novi zapis u KreditnaKartica. Neka procedura prije i nakon umetanja dohvati broj zapisa u tablici. Pozovite proceduru na oba načina. Uklonite proceduru.

--6. Napišite proceduru koja prima tri boje i za svaku boju vraća proizvode u njoj. Pozovite proceduru i nakon toga je uklonite.
GO
CREATE PROCEDURE ProizvodiPoBojama 
			@Boja1 nvarchar(15), @Boja2 nvarchar(15),@Boja3 nvarchar(15)
AS
BEGIN 
	SELECT * FROM Proizvod WHERE Boja = @Boja1;
	SELECT * FROM Proizvod WHERE Boja = @Boja2;
	SELECT * FROM Proizvod WHERE Boja = @Boja3;
END
GO
--Pozovite proceduru
--Bitan redoslijed
EXEC ProizvodiPoBojama 'Crvena', N'Zelena', N'Šarena' --N dodajemo da nam odgovor podržava Č,Ž,Š znakove
GO


/*7. Napišite proceduru koja prima parametre @IDProizvod i @Boja. Parametar @Boja neka bude izlazni parametar. 
Neka procedura za zadani proizvod vrati njegovu boju pomoću izlaznog parametra. 
Pozovite proceduru na oba načina i ispišite vraćenu vrijednost. Uklonite proceduru. */

GO
CREATE PROCEDURE DohvatiBojuProizvoda 
			@IDProizvod int, @Boja nvarchar(15) OUTPUT
AS
BEGIN 
	SELECT @Boja = Boja FROM Proizvod WHERE IDProizvod = @IDProizvod;
END
GO
--SELECT Boja FROM Proizvod WHERE IDProizvod = 679
--Pozovite proceduru
--Potrebno deklarirati varijablu - izlazni parametar
DECLARE @Boja2 nvarchar(15)
EXEC DohvatiBojuProizvoda 679, @Boja2 OUTPUT
PRINT 'Boja proizvoda je:' + @Boja2
GO
--nije bitan redoslijed upisivanja parametara
DECLARE @BojaRezultat nvarchar(15)
EXEC DohvatiBojuProizvoda @IDProizvod = 679, @Boja = @BojaRezultat OUTPUT
PRINT 'Boja proizvoda je:' + @BojaRezultat
GO


/*8. Napišite proceduru koja prima kriterij po kojemu ćete filtrirati prezimena iz tablice Kupac.
Neka procedura pomoću izlaznog parametra vrati broj zapisa koji zadovoljavaju zadani
kriterij. Neka procedura vrati i sve zapise koji zadovoljavaju kriterij. Pozovite proceduru i
ispišite vraćenu vrijednost. Uklonite proceduru.*/



/*9. Napišite proceduru koja za zadanog komercijalistu pomoću izlaznih parametara vraća
njegovo ime i prezime te ukupnu količinu izdanih računa.*/


-- RETURN paramater, provjera postoji li Grad
GO
CREATE PROC GradPostoji
		@GradNaziv nvarchar(30)
AS
BEGIN 
	IF EXISTS (SELECT 1 FROM Grad WHERE Naziv = @GradNaziv)	
		BEGIN 
			RETURN 0;
		END
	ELSE
		BEGIN 
			RETURN 0;
		END
END

GO
--Pozovite proceduru
--Bitan redoslijed
DECLARE @ReturnCode int;
EXEC @ReturnCode = GradPostoji @GradNaziv = 'Zagreb'
IF @ReturnCode = 0
	PRINT 'Grad postoji'
ELSE
	PRINT 'Grad ne postoji'
GO