SELECT * FROM Drzava
SELECT * FROM Grad
SELECT * FROM Proizvod
SELECT * FROM Kategorija
SELECT * FROM Potkategorija
SELECT * FROM Kupac
SELECT * FROM KreditnaKartica
SELECT * FROM KupacVIP


--Umetnite državu Madagaskar.
INSERT INTO Drzava VALUES ('Madagaskar')
SELECT SCOPE_IDENTITY ()
--Umetnite grad Buenos Aires u Argentinu. Pazite na redoslijed!
INSERT INTO Drzava VALUES ('Argentina')
INSERT INTO Grad VALUES ('Buenos Aires', 5)
insert into Grad (Naziv, DrzavaID) select 'Buenos Aires', IDDrzava from Drzava where Naziv = 'Argentina' 
--Umetnite proizvod "Sony Player" cijene 985,50 eura. Potkategorija je "Playeri", kategorija "Razno". Podatke koji nisu zadani izmislite.
SELECT * FROM Potkategorija WHERE Naziv = 'Playeri'
SELECT * FROM Kategorija WHERE Naziv = 'Playeri'
INSERT INTO Kategorija VALUES ('Razno')
INSERT INTO Potkategorija VALUES (5, 'Playeri')
INSERT INTO Proizvod VALUES ('Sony Player', 'SP-2257', 'Crna', 750, 985.50, 38)
SELECT * FROM Proizvod WHERE Naziv = 'Sony Player'
--Umetnite kupca Josipu Josić iz Gospića s emailom josipa@gmail.com i bez telefona.
INSERT INTO Grad VALUES ('Gospić', 1)
INSERT INTO Kupac (Ime, Prezime, Email, Telefon, GradID)
	VALUES ('Josipa', 'Josić', 'josipa@gmail.com', NULL, 16)
	SELECT * FROM Kupac WHERE Ime = 'Josipa'
--Umetnite kreditnu karticu po izboru.
INSERT INTO KreditnaKartica (Tip, Broj, IstekMjesec, IstekGodina)
	VALUES ('MasterCard', '12345678910111', '2', 2026)
	SELECT * FROM KreditnaKartica WHERE IstekGodina = '2026'
--Napravite tablicu KupacVIP sa stupcima ime i prezime. Umetnite u nju sve kupce koji se zove Karen, Mary ili Jimmy.
CREATE TABLE KupacVIP (
IDKupacVIP int CONSTRAINT PK_KupacVIP PRIMARY KEY IDENTITY,
Ime nvarchar(50),
Prezime nvarchar(50)
)
INSERT INTO KupacVIP (Ime, Prezime)
SELECT Ime, Prezime FROM Kupac WHERE Ime IN ('Karen','Mary', 'Jimmy') 

SELECT * FROM KupacVIP

--Umetnite državu Madagaskar.
INSERT INTO Drzava (Naziv) VALUES ('Bahrein')
select SCOPE_IDENTITY() 
--Umetnite grad Buenos Aires u Argentinu. Pazite na redoslijed!
INSERT INTO Drzava (Naziv) VALUES ('Argentina')
select SCOPE_IDENTITY() 
SELECT * FROM Drzava
INSERT INTO Grad(Naziv, DrzavaID) VALUES ('Buenos Aires', 5)
insert into Grad (Naziv, DrzavaID) select 'Buenos Aires', IDDrzava from Drzava where Naziv = 'Argentina' 
--Umetnite proizvod "Sony Player" cijene 985,50 eura. Potkategorija je "Playeri", kategorija "Razno". Podatke koji nisu zadani izmislite.
INSERT INTO Kategorija(Naziv) VALUES ('Razno')
select SCOPE_IDENTITY() 
INSERT INTO Potkategorija(Naziv, KategorijaID) VALUES ('Playeri', 5)
select SCOPE_IDENTITY() 
INSERT INTO Proizvod([Naziv]
      ,[BrojProizvoda]
      ,[Boja]
      ,[MinimalnaKolicinaNaSkladistu]
      ,[CijenaBezPDV]
      ,[PotkategorijaID]) VALUES ('Sony Player',6 ,'Plava' ,5 ,'985,50' ,38 )
select SCOPE_IDENTITY() 
--Umetnite kupca Josipu Josić iz Gospića s emailom josipa@gmail.com i bez telefona.
INSERT INTO Grad(Naziv, DrzavaID) VALUES ('Gospić', 1)
select @@IDENTITY 
INSERT INTO Kupac (Email, Ime,Prezime, GradID) VALUES ('Josipa', 'Josić', 'josipa@gmail.com', 14)

--Umetnite kreditnu karticu po izboru.
INSERT INTO KreditnaKartica (Broj, IstekGodina, IstekMjesec, Tip) VALUES (431431434, 2027, 11, 'Visa')
--Napravite tablicu KupacVIP sa stupcima ime i prezime. Umetnite u nju sve kupce koji se zove Karen, Mary ili Jimmy.
CREATE TABLE KupacVIP (
IDKupacVIP int PRIMARY KEY IDENTITY,
Ime nvarchar(40),
Prezime nvarchar(50)
)

INSERT INTO KupacVIP
SELECT Ime, Prezime FROM Kupac WHERE Ime IN ('Karen', 'Mary', 'Jimmy')

SELECT * FROM Grad
SELECT * FROM Kupac

--Kupcu Kim Abercrombie promijenite prebivalište u Osijek. Kojem točno kupcu treba promijeniti prebivalište?
SELECT * FROM Kupac WHERE Ime = 'Kim' AND Prezime = 'Abercrombie'
UPDATE Kupac SET GradID = 2 WHERE Ime = 'Kim' AND Prezime = 'Abercrombie'
select @@IDENTITY
--Kupcima čije prezime započinje sa slovom A promijenite prebivalište u Rijeka
SELECT * FROM Kupac WHERE Prezime LIKE 'A%'
UPDATE Kupac SET GradID = 4 WHERE Prezime LIKE 'A%'
--Kupcima s ID-evima 40, 41 i 42 promijenite e-mail u nepoznato@nepoznato.com
UPDATE Kupac SET Email = 'nepoznato@nepoznato.com' WHERE IDKupac IN (40, 41, 42)
select @@IDENTITY 
SELECT * FROM Kupac WHERE IDKupac IN (40, 41, 42)
--Kupcu Eduardo Diaz promijenite ime u Edo
SELECT * FROM Kupac WHERE Ime = 'Eduardo' AND Prezime = 'Diaz'
UPDATE Kupac SET Ime = 'Edo' WHERE Ime = 'Eduardo' AND Prezime = 'Diaz'
select SCOPE_IDENTITY() 
SELECT * FROM Kupac WHERE Ime = 'Edo' AND Prezime = 'Diaz'
--Svim računima izdanim 01.04.2004. za koje se ne zna komercijalist i koji nisu plaćeni kreditnom karticom upišite komentar "Dodatno provjeriti!"
SELECT * FROM Racun WHERE DatumIzdavanja = '20040401' AND KomercijalistID IS NULL  AND KreditnaKarticaID IS NULL 
UPDATE Racun SET Komentar = 'Dodatno provjeriti!' WHERE DatumIzdavanja = '20040401' AND KomercijalistID IS NULL AND KreditnaKarticaID IS NULL
SELECT * FROM Racun WHERE DatumIzdavanja = '20040401' AND KomercijalistID IS NULL  AND KreditnaKarticaID IS NULL


--Kupcu Kim Abercrombie promijenite prebivalište u Osijek. Kojem točno kupcu treba promijeniti prebivalište?
UPDATE Kupac SET GradID = 2 WHERE Ime = 'Kim' AND Prezime = 'Abercrombie'
--Kupcima čije prezime započinje sa slovom A promijenite prebivalište u Rijeka
UPDATE Kupac SET GradID = 4 WHERE Prezime LIKE 'A%'
--Kupcima s ID-evima 40, 41 i 42 promijenite e-mail u nepoznato@nepoznato.com
UPDATE Kupac SET Email = 'nepoznato@nepoznato.com' WHERE IDKupac BETWEEN 40 AND 42
--Kupcu Eduardo Diaz promijenite ime u Edo
UPDATE Kupac SET Ime='Edo' WHERE Ime = 'Eduardo' AND Prezime = 'Diaz'
--Svim računima izdanim 01.04.2004. za koje se ne zna komercijalist i koji nisu plaćeni kreditnom karticom upišite komentar "Dodatno provjeriti!"
SELECT * FROM Racun WHERE DatumIzdavanja = '20040401' AND KomercijalistID IS NULL AND KreditnaKarticaID IS NULL
UPDATE Racun SET Komentar = 'Dodatno provjeriti!' WHERE DatumIzdavanja = '20040401' AND KomercijalistID IS NULL AND KreditnaKarticaID IS NULL


--Obrišite državu Njemačku. U čemu je problem i kako ga riješiti?
SELECT * FROM Grad
DELETE FROM Grad WHERE DrzavaID = 2
SELECT * FROM Drzava
SELECT * FROM Kupac
SELECT * FROM Racun
DELETE FROM Racun WHERE KupacID IN (6,7,8)
DELETE FROM Kupac WHERE GradID IN (6,7,8)
DELETE FROM Drzava WHERE IDDrzava = 2
--Obrišite sve kupce koji se prezivaju Trtimirović. Je li se dogodila pogreška? Koliko ih je obrisano? 
SELECT * FROM Kupac WHERE Prezime = 'Trtimirović'
DELETE FROM Kupac WHERE Prezime = 'Trtimirović'
--Obrišite račun s ID-em 75123.SELECT * FROM Grad
SELECT * FROM


--Upisati u bazu činjenicu da je 18.05.2011. Robertu Mrkonjiću (robi.mrki@gmail.si) iz Ljubljane izdan račun 
--RN18052011 za troje bijele trkaće čarape veličine M i za 2 naljepnice za bicikl. 
--Na nijedan artikl nije bilo popusta. Kupac je platio gotovinom, a prodaju je napravio novi komercijalist Garfild Mačković.
SELECT * FROM Kupac WHERE Ime = 'Robert' AND Prezime = 'Mrkonjić'
SELECT * FROM Grad
SELECT * FROM Drzava
SELECT * FROM Racun
SELECT * FROM Proizvod
INSERT INTO Drzava VALUES ('Slovenija')
SELECT SCOPE_IDENTITY() 
INSERT INTO Grad(Naziv, DrzavaID) VALUES ('Ljubljana', 4)
SELECT SCOPE_IDENTITY() 
INSERT INTO Kupac (Ime,Prezime, Email, Telefon, GradID) VALUES ('Robert', 'Mrkonjić', 'robi.mrki@gmail.si', NULL, 15)
SELECT * FROM Kupac WHERE Prezime = 'Mrkonjić'
INSERT INTO Proizvod(Naziv, BrojProizvoda, Boja, MinimalnaKolicinaNaSkladistu, CijenaBezPDV) VALUES ('Trkaće čarape', 'SB-153', 'Bijela', 150, 14)
INSERT INTO Proizvod(Naziv, BrojProizvoda, Boja, MinimalnaKolicinaNaSkladistu, CijenaBezPDV) VALUES ('Naljepnice za bicikl', 'SB-154', 'BMX', 150, 3)
SELECT * FROM Komercijalist WHERE Ime = 'Garfild'
INSERT INTO Racun([DatumIzdavanja]
      ,[BrojRacuna]
      ,[KupacID]
      ,[KomercijalistID]
      ,[KreditnaKarticaID]
      ,[Komentar]) VALUES ('2011-05-18', 'RN18052011', 19978, 287, NULL, NULL)
SELECT * FROM Racun WHERE KupacID = 19978
SELECT * FROM Proizvod WHERE Naziv LIKE 'Trka%'
  INSERT INTO Stavka ([RacunID]
      ,[Kolicina]
      ,[ProizvodID]
      ,[CijenaPoKomadu]
      ,[PopustUPostocima]
      ,[UkupnaCijena]) VALUES ( 75124, 3, 1000, 14, 0, 42)

SELECT * FROM Proizvod WHERE Naziv LIKE 'Nalj%'

INSERT INTO Stavka ([RacunID]
      ,[Kolicina]
      ,[ProizvodID]
      ,[CijenaPoKomadu]
      ,[PopustUPostocima]
      ,[UkupnaCijena]) VALUES ( 75124, 2, 1001, 3, 0, 6)

SELECT * FROM Stavka WHERE ProizvodID = 1000
SELECT * FROM Stavka WHERE ProizvodID = 1001




--Promijenite u bazi netočan podatak da je gospodin Mrkonjić iz Ljubljane; on je ustvari iz Beča.
SELECT * FROM Grad
SELECT * FROM Drzava
INSERT INTO Drzava VALUES ('Austrija')
SELECT SCOPE_IDENTITY ()
INSERT INTO Grad VALUES ('Beč', 5)
SELECT SCOPE_IDENTITY ()
UPDATE Kupac SET GradID = 17 WHERE Prezime = 'Mrkonjić'

--Promijenite u bazi netočan podatak da je gospodin Mrkonjić kupio naljepnice; on je ustvari kupio samo čarape.

DELETE FROM Stavka WHERE RacunID = 75124 AND ProizvodID = 1001

