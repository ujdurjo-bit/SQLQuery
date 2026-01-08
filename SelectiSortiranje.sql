--Dohvati sve kupce iz tablice Kupac: 
--Koji se zovu Lili
SELECT * FROM Kupac WHERE Ime = 'Lili'
--Koji se prezivaju Lee
SELECT * FROM Kupac WHERE Prezime = 'Lee'
--Koji se zovu Ana i prezivaju Diaz
SELECT * FROM Kupac WHERE Ime = 'Ana' AND Prezime = 'Diaz'
--Koji su iz Osijeka
SELECT * FROM Grad WHERE Naziv = 'Osijek'
SELECT * FROM Kupac WHERE  GradID = 2
--Koji se zovu Ana ili Tamara
SELECT * FROM Kupac WHERE Ime IN ('Ana','Tamara')
--Koji se zovu Ana ili Tamara i iz Osijeka su
SELECT * FROM Kupac WHERE Ime IN ('Ana', 'Tamara') AND GradID = 2
--Koji se zovu Ana ili Tamara i nisu iz Osijeka
SELECT * FROM Kupac WHERE Ime IN ('Ana', 'Tamara') AND GradID != 2


--Dohvatiti sve stavke iz tablice Stavka:
--Čija je ukupna cijena manja od 2 eura
SELECT * FROM Stavka WHERE UkupnaCijena < 2 
--Čija je ukupna cijena veća ili jednaka 23000 eura
SELECT * FROM Stavka WHERE UkupnaCijena >= 23000 
--Čija je količina veća ili jednaka 20 i manja ili jednaka 22
SELECT * FROM Stavka WHERE Kolicina >= 20 AND Kolicina <= 22

--Dohvatiti sve proizvode iz tablice Proizvod:
--Čija je boja plava ili crvena
SELECT * FROM Proizvod WHERE Boja IN ('Plava', 'Crvena') 
--Čija boja nije definirana
SELECT * FROM Proizvod WHERE Boja IS NULL
--Čija je boja srebrna ili nije definirana
SELECT * FROM Proizvod WHERE Boja = 'Srebrna' OR Boja IS NULL
--Čija je boja definirana
SELECT * FROM Proizvod WHERE Boja IS NOT NULL
--Čija boja nije definirana i cijena je manja od 25 eura
SELECT * FROM Proizvod WHERE Boja IS NULL AND CijenaBezPDV <25


--Dohvatiti sve račune iz tablice Racun:
--Koji su izdani 14.7.2004.
SELECT * FROM Racun
SELECT * FROM Racun WHERE DatumIzdavanja = '20040714'
--Koji su izdani 14.7.2004. ili 15.7.2004.
SELECT * FROM Racun WHERE DatumIzdavanja IN ('20040714', '20040715')
--Koji su izdani između 14.7.2004. i 21.7.2004.
SELECT * FROM Racun WHERE DatumIzdavanja BETWEEN '2004-07-14' AND '2004-07-15 23:59:59';


--Dohvatiti sve kupce iz tablice Kupac:
--Čija je vrijednost primarnog ključa 10, 25, 74 ili 154
SELECT * FROM Kupac WHERE IDKupac IN (10, 25, 74, 154)
--Čije ime započinje slovima "Ki"
SELECT * FROM Kupac WHERE Ime LIKE 'Ki%'
--Čije prezime završava slovima "ams"
SELECT * FROM Kupac WHERE Ime LIKE '%ams'
--Čije prezime započinje slovom "D" i prezime sadržava string "re"
SELECT * FROM Kupac WHERE Prezime LIKE 'D%' AND Prezime LIKE '%re%'


--Primjeri
SELECT Ime AS KupacIme, Prezime AS KupacPrezime FROM Kupac WHERE Ime LIKE 'Ki%'
SELECT Ime + ' ' +Prezime AS KupacPunoIme FROM Kupac WHERE Ime LIKE 'Ki%'

--Dohvatiti iz tablice Kupac:

--Imena i prezimena osoba čije ime počinje s "Ki"
SELECT Ime, Prezime FROM Kupac WHERE Ime LIKE 'Ki%'
--Imena i prezimena osoba koji imaju primarni ključ između 15530 i 15535. Prvi stupac preimenovati u "Ime", drugi u "Prezime"
SELECT Ime AS KupacIme, Prezime AS KupacPrezime FROM Kupac WHERE IDKupac BETWEEN 15530 AND 15535
--Jedan stupac PunoIme koji se sastoji od spojenog prezimena i imena za sve osobe. 
SELECT Prezime + ' ' +Ime AS PunoIme FROM Kupac
--Ime, Prezime, PunoIme, te email adresu
SELECT Ime, Prezime, Ime + ' ' +Prezime AS PunoIme, Email FROM Kupac
--Jedinstvena imena
SELECT DISTINCT Ime  FROM Kupac
--Jedinstvena prezimena
SELECT DISTINCT Prezime FROM Kupac
--Jedinstvena imena i prezimena
SELECT DISTINCT Ime, Prezime FROM Kupac
SELECT * FROM Kupac



SELECT DISTINCT Ime, Prezime FROM Kupac ORDER BY  Prezime, Ime DESC


--Dohvatiti iz tablice Kupac:

--Imena i prezimena osoba čije ime počinje s "Kat", sortirane prema imenu uzlazno pa prema prezimenu uzlazno
SELECT DISTINCT Ime, Prezime FROM Kupac WHERE Ime LIKE 'Kat%' ORDER BY  Ime, Prezime 
--Imena i prezimena osoba čije ime počinje s "Kat", sortirane prema imenu uzlazno pa prema prezimenu silazno
SELECT DISTINCT Ime, Prezime FROM Kupac WHERE Ime LIKE 'Kat%' ORDER BY  Ime, Prezime DESC
--Imena i prezimena osoba koji imaju primarni ključ između 18150 i 18155. Prvi stupac preimenovati u "Ime", drugi u "Prezime". Sortirati prema stupcu Prezime silazno.
SELECT DISTINCT Ime AS KupacIme, Prezime AS KupacPrezime FROM Kupac WHERE IDKupac BETWEEN 18150 AND 18155 ORDER BY KupacPrezime DESC
--Jedan stupac PunoIme koji se sastoji od spojenog prezimena i imena za sve osobe. Sortirati uzlazno.
SELECT DISTINCT Prezime + ' ' +Ime AS PunoIme FROM Kupac ORDER BY PunoIme
--Jedan stupac PunoIme koji se sastoji od spojenog prezimena i imena za sve osobe. Sortirati silazno.
SELECT DISTINCT Prezime + ' ' +Ime AS PunoIme FROM Kupac ORDER BY PunoIme DESC


--Dohvatiti iz tablice Kupac:

--Prvih 5 redaka iz tablice
SELECT TOP 5 * FROM Kupac
--Imena i prezimena zadnjih 5 redaka iz tablice
SELECT DISTINCT TOP 5 * FROM Kupac ORDER BY IDKupac DESC
--Polovicu prvih osoba koje se zovu "Jack"
SELECT DISTINCT TOP (50) PERCENT * FROM Kupac WHERE Ime = 'Jack' ORDER BY Prezime
--Samo prezimena polovice prvih osoba koje se zovu "Jack"
SELECT DISTINCT TOP (50) PERCENT Prezime FROM Kupac WHERE Ime = 'Jack' ORDER BY Prezime