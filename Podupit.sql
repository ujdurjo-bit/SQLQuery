SELECT 
		Naziv,
		Boja,
		CijenaBezPDV
FROM Proizvod
WHERE CijenaBezPDV > 
	(SELECT AVG(CijenaBezPDV) -- podupit koji vraća vrijednost 631.7002
	 FROM Proizvod)
ORDER BY 
		CijenaBezPDV DESC

--Konstantni:
	SELECT Naziv,
		(
			SELECT COUNT(*) 
			FROM Proizvod
		) AS BrojProizvoda
	FROM Proizvod

--Korelirani:
	SELECT TOP 5 Naziv,
	(
		SELECT SUM(s.Kolicina) 
		FROM Stavka AS s
	WHERE s.ProizvodID =p.IDProizvod
	) AS Prodano
	FROM Proizvod AS p
	ORDER BY Prodano DESC


  --Konstatni:
	SELECT 
		Naziv
	FROM Proizvod
	WHERE CijenaBezPDV > 
	(
		SELECT AVG(CijenaBezPDV) 
		FROM Proizvod
	)

--Korelirani s operatorom uspoređivanja:
	SELECT *
	FROM Kupac AS k
	WHERE 
	(
		SELECT COUNT(*) 
		FROM Racun AS r
 		WHERE r.KupacID =k.IDKupac
	) >= 27


	--Konstantni s operatorom IN:
	SELECT *
	FROM Proizvod AS p
	WHERE IDProizvod IN 
	(
		SELECT DISTINCT 	
		s.ProizvodID
		FROM Stavka AS s
	)
--Korelirani s operatorom EXISTS:
	SELECT *
	FROM Proizvod AS p
	WHERE EXISTS
	(
		SELECT * 
		FROM Stavka AS s
	WHERE s.ProizvodID =p.IDProizvod
	)



--Ispišite sve potkategorije i za svaku ispišite broj proizvoda u njoj.

SELECT 
Naziv AS PotKategorija,
 (SELECT COUNT (*) FROM Proizvod AS pr WHERE pr.PotkategorijaID = pk.IDPotkategorija) AS BrojProizvoda
 FROM Potkategorija pk
ORDER BY BrojProizvoda DESC


--Riješite prethodni zadatak pomoću spajanja.

SELECT 
p.Naziv AS PotKategorija,
COUNT(pr.IDProizvod) AS BrojProizvoda
FROM Potkategorija AS p
INNER JOIN Proizvod pr ON p.IDPotkategorija = pr.PotkategorijaID
GROUP BY p.Naziv
ORDER BY p.Naziv DESC

--Ispišite sve kategorije i za svaku ispišite broj proizvoda u njoj.

SELECT 
k.Naziv AS NazivKAtegorije,
COUNT(p.IDProizvod) AS BrojProizvoda
FROM Kategorija AS k
INNER JOIN Potkategorija pk ON k.IDKategorija = pk.KategorijaID
INNER JOIN Proizvod p ON pk.IDPotkategorija = p.PotkategorijaID
GROUP BY k.Naziv
ORDER BY k.Naziv

--Ispišite sve proizvode i pokraj svakog ispišite zarađeni iznos, od najboljih prema lošijim.

SELECT 
p.Naziv AS Proizvod,
(
	SELECT SUM(s.Kolicina * s.CijenaPoKomadu)
	FROM Stavka s
	WHERE s.ProizvodID = p.IDProizvod
    ) AS Zarada
FROM 
    Proizvod AS p
ORDER BY 
    Zarada DESC;

--Dohvatite sve proizvode, uz svaki proizvod ispišite prosječnu cijenu svih proizvoda te razliku prosječne cijene svih proizvoda i cijene tog proizvoda. 
--U obzir uzmite samo proizvode s cijenom većom od nule.

SELECT
p.Naziv AS Proizvod,
p.CijenaBezPDV AS Cijena,
(
	SELECT AVG(CijenaBezPDV)
	FROM Proizvod
	WHERE CijenaBezPDV > 0
	) AS ProsjecnaCijena,

((	SELECT AVG(CijenaBezPDV)
	FROM Proizvod
	WHERE CijenaBezPDV > 0) - p.CijenaBezPDV) AS Razlika

FROM Proizvod AS p
WHERE CijenaBezPDV > 0
ORDER BY p.Naziv



--Dohvatite imena i prezimena 5 komercijalista koji su izdali najviše računa.

SELECT TOP 5
k.Ime, k.Prezime,
COUNT(r.IDRacun) AS BrojRacuna
FROM Komercijalist AS k
INNER JOIN Racun AS r ON k.IDKomercijalist = r.KomercijalistID
GROUP BY k.Ime, k.Prezime
ORDER BY BrojRacuna DESC


--Dohvatite imena i prezimena 5 najboljih komercijalista po broju realiziranih računa te uz svakog dohvatite i iznos prodane robe.

SELECT TOP 5
k.Ime, k.Prezime,
(SELECT SUM(s.Kolicina * s.CijenaPoKomadu)
	FROM Racun AS r
	INNER JOIN Stavka AS s ON r.IDRacun = s.RacunID
	WHERE r.KomercijalistID = k.IDKomercijalist) AS UkupniIznos,

COUNT(r.IDRacun) AS BrojRacuna
FROM Komercijalist AS k
INNER JOIN Racun AS r ON k.IDKomercijalist = r.KomercijalistID
GROUP BY k.IDKomercijalist, k.Ime, k.Prezime
ORDER BY BrojRacuna DESC

--Dohvatite sve boje proizvoda. Uz svaku boju pomoću podupita dohvatite broj proizvoda u toj boji.

SELECT Boja,
	(SELECT COUNT(*)
	FROM Proizvod pro WHERE pro.Boja = pr.Boja) AS BrojProizvoda
	FROM Proizvod pr
	WHERE Boja IS NOT NULL
	GROUP BY Boja
	ORDER BY Boja DESC


--Dohvatite imena i prezimena svih kupaca iz Frankfurta i uz svakog ispišite broj računa koje je platio karticom, od višeg prema nižem.

SELECT Ime, Prezime, GradID,
	(
	SELECT COUNT(*) 
	FROM Racun r 
	WHERE ku.IDKupac = r.KupacID AND r.KreditnaKarticaID IS NOT NULL) AS BrojRacunaPlacenihKarticom
FROM Kupac ku
WHERE GradID = 
	(SELECT gr.IDGrad
	FROM Grad gr
	WHERE Naziv = 'Frankfurt'
	)
ORDER BY BrojRacunaPlacenihKarticom DESC



--Vratite sve proizvode čija je cijena pet ili više puta veća od prosjeka.

SELECT Naziv AS Nazivproizvoda, CijenaBezPDV
	FROM Proizvod 
	WHERE CijenaBezPDV >= (SELECT AVG(CijenaBezPDV) * 5 FROM Proizvod)


--Vratite sve proizvode koji su prodavani, ali u količini manjoj od 5.

SELECT p.Naziv AS Nazivproizvoda, SUM(s.Kolicina) AS Ukupnoprodano
FROM Proizvod p
INNER JOIN Stavka s ON p.IDProizvod = s.ProizvodID
GROUP BY p.Naziv
HAVING SUM(s.Kolicina) < 5

--Vratite sve proizvode koji nikad nisu prodani:
	--Pomoću IN ili NOT IN
	--Pomoću EXISTS ili NOT EXISTS
	--Pomoću spajanja

SELECT *
FROM Proizvod p
WHERE IDProizvod NOT IN 
	(SELECT DISTINCT ProizvodID
	FROM Stavka)

SELECT *
FROM Proizvod p
WHERE NOT EXISTS 
	(SELECT *
	FROM Stavka s
	WHERE s.ProizvodID = p.IDProizvod)

SELECT *
FROM Proizvod p
LEFT JOIN Stavka s ON p.IDProizvod = s.ProizvodID
WHERE s.ProizvodID IS NULL

--Vratite količinu zarađenog novca za svaku boju proizvoda.

SELECT p.Boja,
SUM(s.UkupnaCijena) AS UkupnaZarada
FROM Proizvod p
JOIN Stavka s ON p.IDProizvod = s.ProizvodID
GROUP BY p.Boja

--Vratite količinu zarađenog novca za svaku boju proizvoda, ali samo za one boje koje su zaradile više od 20.000.000.

SELECT p.Boja,
SUM(s.UkupnaCijena) AS UkupnaZarada
FROM Proizvod p
JOIN Stavka s ON p.IDProizvod = s.ProizvodID
GROUP BY p.Boja
HAVING SUM(s.UkupnaCijena) > 20000000

--Vratiti sve proizvode koji imaju dodijeljenu potkategoriju i koji su prodani u količini većoj od 5000. Uz svaki proizvod vratiti prodanu količinu i naziv kategorije.


SELECT p.IDProizvod, p.Naziv AS NazivProizvoda, 
SUM(s.Kolicina) AS UkupnoProdano, 
k.Naziv AS NazivKategorije 
FROM Proizvod p 
INNER JOIN Potkategorija pk ON p.PotkategorijaID = pk.IDPotkategorija 
INNER JOIN Kategorija k ON pk.KategorijaID = k.IDKategorija 
INNER JOIN Stavka s ON p.IDProizvod = s.ProizvodID 
GROUP BY p.IDProizvod, p.Naziv, k.Naziv 
HAVING SUM(s.Kolicina) > 5000 
ORDER BY UkupnoProdano DESC;


--Upit u FROM dijelu je privremena tablica
SELECT Podaci.PotkategorijaID, Podaci.Boja, Podaci.Kolicina
FROM (
    SELECT PotkategorijaID, Boja, COUNT(*) AS Kolicina
    FROM Proizvod
    WHERE PotkategorijaID IS NOT NULL
    GROUP BY PotkategorijaID, Boja
) AS Podaci
WHERE Podaci.Kolicina > 10
ORDER BY Podaci.Kolicina DESC;


