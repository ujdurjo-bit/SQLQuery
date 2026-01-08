--Inner Join (Spajanje) Prikaz podataka samo, nije spremanje
SELECT g.Naziv AS NazivGrada, d.Naziv AS NazivDrzave 
FROM Grad AS g 
INNER JOIN Drzava AS d ON g.DrzavaID = d.IDDrzava



--Filtriranje i sortiranje
SELECT g.Naziv AS NazivGrada, d.Naziv AS NazivDržave 
FROM Grad AS g 
INNER JOIN Drzava AS d ON g.DrzavaID = d.IDDrzava
WHERE g.Naziv LIKE 'S%' OR g.Naziv LIKE 'Z%'
ORDER BY NazivDržave DESC

--Zadaci
--Dohvatiti imena i prezimena svih kupaca i uz svakog ispisati naziv grada.
SELECT K.Ime, K.Prezime, G.Naziv AS Grad
FROM Kupac AS K
INNER JOIN Grad AS G ON K.GradID = G.IDGrad

--Dohvatiti imena i prezimena svih kupaca i uz svakog ispisati naziv grada i države.
SELECT K.Ime, K.Prezime, G.Naziv AS Grad, D.Naziv AS Država
FROM Kupac AS K
INNER JOIN Grad AS G ON  G.IDGrad = K.GradID
INNER JOIN Drzava AS D ON G.DrzavaID = D.IDDrzava


SELECT
		MIN(CijenaBezPDV) AS NajnizaCijena,
		MAX(CijenaBezPDV) AS NajvisaCijena,
		AVG(CijenaBezPDV) AS ProsjecnaCijena
	FROM Proizvod
	WHERE CijenaBezPDV > 0

SELECT * FROM Kupac WHERE Telefon IS NULL
SELECT Ime, ISNULL(Telefon, 0) FROM Kupac WHERE Telefon IS NULL


--Za pretvaranje tipova podataka koristimo funkciju CAST():
--CAST(vrijednost AS tip)
--Primjerice: CAST(Broj as float)

--COUNT(stupac) će vratiti broj redaka koji nemaju NULL vrijednost upisanu u stupac
--COUNT(*) će vratiti ukupni broj redaka, bez obzira na NULL vrijednosti


--Zadaci: 
--Vratite broj svih proizvoda.
SELECT COUNT(*) FROM Proizvod

--Vratite broj proizvoda koji imaju definiranu boju.
SELECT COUNT(Boja) AS ProizvodiSBojom FROM Proizvod

--Vratite najvišu cijenu proizvoda.
SELECT MAX(CijenaBezPDV) FROM Proizvod

--Vratite prosječnu cijenu proizvoda iz potkategorije 16.
SELECT AVG(CijenaBezPDV) FROM Proizvod
WHERE PotkategorijaID = 16 AND CijenaBezPDV > 0

--Vratite datume najstarijeg i najnovijeg računa izdanog kupcu 131.
SELECT 
		MIN(DatumIzdavanja) AS NajstarijiRačun,
		MAX(DatumIzdavanja) AS NAjnovijiRačun 
FROM Racun
WHERE KupacID = 131

SELECT 
Boja, COUNT(*) AS BrojProizvoda
FROM Proizvod
WHERE Boja IS NOT NULL
GROUP BY Boja 

SELECT 
Boja, PotkategorijaID, COUNT(*) AS Kolicina
FROM Proizvod
GROUP BY Boja, PotkategorijaID
ORDER BY Boja, PotkategorijaID 


--Zadaci:
--Ispišite sve boje proizvoda i pokraj svake napišite koliko proizvoda ima tu boju.
SELECT 
Boja, COUNT(*) AS BrojProizvoda
FROM Proizvod
GROUP BY Boja

--Promijenite prethodni upit tako da sortirate padajuće prema broju proizvoda.
SELECT 
Boja, COUNT(*) AS BrojProizvoda
FROM Proizvod
GROUP BY Boja ORDER BY BrojProizvoda DESC

--Promijenite prethodni upit tako da isključite nedefiniranu boju.

SELECT 
Boja, COUNT(*) AS BrojProizvoda
FROM Proizvod
WHERE Boja IS NOT NULL
GROUP BY Boja ORDER BY BrojProizvoda DESC

--Ispišite koliko proizvoda svake boje ima u svakoj od potkategorija. Sortirajte prema potkategoriji i prema boji.
SELECT 
Boja, PotkategorijaID, COUNT(*) AS BrojProizvoda
FROM Proizvod
WHERE Boja IS NOT NULL AND PotkategorijaID IS NOT NULL
GROUP BY Boja, PotkategorijaID
ORDER BY PotkategorijaID, Boja  


--Promijenite prethodni upit tako da ispišete 10 kategorija i boja s najviše proizvoda.
SELECT TOP 10 
Boja, PotkategorijaID, COUNT(*) AS BrojProizvoda
FROM Proizvod
WHERE Boja IS NOT NULL AND PotkategorijaID IS NOT NULL
GROUP BY Boja, PotkategorijaID
ORDER BY BrojProizvoda DESC


SELECT TOP 10 
Boja, PotkategorijaID, COUNT(*) AS BrojProizvoda
FROM Proizvod
WHERE Boja IS NOT NULL AND PotkategorijaID IS NOT NULL
GROUP BY Boja, PotkategorijaID
HAVING COUNT(*) >14
ORDER BY BrojProizvoda DESC


--Ispišite sve boje koje imaju više od 40 proizvoda.
SELECT 
Boja, COUNT(*) AS BrojProizvoda
FROM Proizvod
WHERE Boja IS NOT NULL
GROUP BY Boja
HAVING COUNT(*) > 40

--Ispišite nazive svih potkategorija koje sadržavaju više od 10 proizvoda.
SELECT 
PotkategorijaID, COUNT(*) AS BrojProizvoda
FROM Proizvod
WHERE PotkategorijaID IS NOT NULL
GROUP BY PotkategorijaID
HAVING COUNT(*) > 10

SELECT 
  p.Naziv, COUNT(pr.PotkategorijaID) AS BrojProizvoda
FROM Potkategorija p
JOIN Proizvod pr ON pr.PotkategorijaID = p.IDPotkategorija
GROUP BY p.Naziv
HAVING COUNT(pr.PotkategorijaID) > 10;


SELECT g.Naziv AS NazivGrada, d.Naziv AS NazivDržave 
FROM Grad AS g 
INNER JOIN Potka AS d ON g.DrzavaID = d.IDDrzava
WHERE g.Naziv LIKE 'S%' OR g.Naziv LIKE 'Z%'
ORDER BY NazivDržave DESC


--Praznici
--Za sve račune izdane 01.08.2002. i plaćene American Expressom ispisati njihove ID-eve i brojeve te ime i prezime i grad kupca, ime i prezime komercijaliste 
--te broj i podatke o isteku kreditne kartice. Rezultate sortirati prema prezimenu kupca.
SELECT 
r.IDRacun AS RacunID, 
k.Ime AS ImeKupca, k.Prezime AS PrezimeKupca, 
g.Naziv AS GradKupca,
kom.Ime AS ImeKomercijalista, kom.Prezime AS PrezimeKomercijalista, 
kk.Broj AS BrojKartice,
kk.IstekMjesec,
kk.IstekGodina
FROM Racun AS r
INNER JOIN Kupac AS k ON  k.IDKupac = r.KupacID
INNER JOIN Grad AS g ON g.IDGrad = k.GradID
INNER JOIN Komercijalist AS kom ON kom.IDKomercijalist = r.KomercijalistID
INNER JOIN KreditnaKartica AS kk ON kk.IDKreditnaKartica = r.KreditnaKarticaID

WHERE r.Datumizdavanja = '2002-08-01' AND kk.Tip LIKE 'American Express'
ORDER BY k.Prezime

--Ispisati nazive proizvoda koji su na nekoj stavci računa prodani u više od 35 komada. Svaki proizvod navesti samo jednom.
SELECT DISTINCT 
p.Naziv AS NazivProizvoda 
FROM Stavka AS s
INNER JOIN Proizvod AS p ON s.ProizvodID = p.IDProizvod
WHERE s.Kolicina > 35

--Promijenite prethodni upit tako da umjesto ID potkategorije ispišete njen naziv.
SELECT DISTINCT 
p.Naziv AS NazivProizvoda, 
pk.Naziv AS NAzivPotkategorije
FROM Stavka AS s
INNER JOIN Proizvod p ON s.ProizvodID = p.IDProizvod
INNER JOIN Potkategorija AS pk ON p.PotkategorijaID = pk.IDPotkategorija
WHERE s.Kolicina > 35

--Ispišite nazive svih kategorija i pokraj svake napišite koliko potkategorija je u njoj.
SELECT 
k.Naziv AS NazivKAtegorije,
COUNT(pk.IDPotkategorija) AS BrojPotkategorija
FROM Kategorija AS k
JOIN Potkategorija AS pk ON k.IDKategorija = pk.KategorijaID
GROUP BY k.Naziv
ORDER BY k.Naziv


--Ispišite nazive svih kategorija i pokraj svake napišite koliko proizvoda je u njoj.
SELECT 
k.Naziv AS NazivKAtegorije,
COUNT(p.IDProizvod) AS BrojProizvoda
FROM Kategorija AS k
INNER JOIN Potkategorija pk ON k.IDKategorija = pk.KategorijaID
INNER JOIN Proizvod AS p ON pk.IDPotkategorija = p.PotkategorijaID
GROUP BY k.Naziv
ORDER BY k.Naziv

--Ispišite sve različite cijene proizvoda i napišite koliko proizvoda ima svaku cijenu.
SELECT
CijenaPoKomadu,
COUNT(*) AS BrojProizvoda
FROM Stavka
GROUP BY CijenaPoKomadu
ORDER BY CijenaPoKomadu

--Ispišite koliko je računa izdano koje godine.

SELECT YEAR(DatumIzdavanja) AS GodinaIzdavanja,
COUNT(*) AS BrojRačuna
FROM Racun
GROUP BY YEAR(DatumIzdavanja)
ORDER BY GodinaIzdavanja

--Ispišite brojeve svih račune izdane kupcu 377 i pokraj svakog ispišite ukupnu cijenu po svim stavkama.
SELECT
r.BrojRacuna,
SUM(s.Kolicina * s.CijenaPoKomadu) AS UkupnaCijena
FROM 
Racun AS r
INNER JOIN Stavka s ON r.IDRacun = s.RacunID
WHERE KupacID = '377'
GROUP BY r.BrojRacuna;

--Ispišite ukupno zarađene iznose i broj prodanih primjeraka za svaki od ikad prodanih proizvoda.
SELECT
p.IDproizvod, p.Naziv,
SUM(s.Kolicina * s.CijenaPoKomadu) AS UkupnaZarada,
SUM(s.Kolicina) AS UkupnaProdaja
FROM 
Stavka AS s
INNER JOIN Proizvod AS p ON s.ProizvodID = p.IDProizvod
GROUP BY 
    p.IDProizvod,
    p.Naziv

--Ispišite ukupno zarađene iznose za svaki od proizvoda koji je prodan u više od 2000 primjeraka.
SELECT
p.IDproizvod, p.Naziv,
SUM(s.Kolicina * s.CijenaPoKomadu) AS UkupnaZarada,
SUM(s.Kolicina) AS UkupnaProdaja
FROM 
Stavka AS s
INNER JOIN Proizvod AS p ON s.ProizvodID = p.IDProizvod
GROUP BY 
    p.IDProizvod,
    p.Naziv
HAVING SUM(s.Kolicina) > 2000


--Ispišite ukupno zarađene iznose za svaki od proizvoda koji je prodan u više od 2.000 primjeraka ili je zaradio više od 2.000.000 dolara.
SELECT
p.IDproizvod, p.Naziv,
SUM(s.Kolicina * s.CijenaPoKomadu) AS UkupnaZarada,
SUM(s.Kolicina) AS UkupnaProdaja
FROM 
Stavka AS s
INNER JOIN Proizvod AS p ON s.ProizvodID = p.IDProizvod
GROUP BY 
    p.IDProizvod,
    p.Naziv
HAVING SUM(s.Kolicina) > 2000 OR SUM(s.Kolicina * s.CijenaPoKomadu) > 2000000;