---BZDN_C3: tworzenie 

---Definicja tabel---
CREATE TABLE dbo.Klient
(
	IdKlient int NOT NULL,
	Imie varchar(30) NOT NULL,
	Nazwisko varchar(30) NOT NULL,
	NrTel varchar(20) NOT NULL,
	Pesel bigint NOT NULL,
	E_mail varchar(50) NOT NULL,
	
);
GO
CREATE TABLE dbo.Rezerwacja
(
	IdRezerwacja int NOT NULL,
	DataZlozenia date NOT NULL,
	KwotaLaczna money NOT NULL,
	IdKlient int NOT NULL,
);
GO
CREATE TABLE dbo.Bilet
(
	IdBilet int NOT NULL,
	IdRezerwacja int NOT NULL,
	IdSeans int NOT NULL,
	Miejsce varchar(10) NOT NULL,
	
);
GO
CREATE TABLE dbo.Seans
(
	IdSeans int NOT NULL,
	IdFilm int NOT NULL,
	DataGodzina date NOT NULL,
	IdSala int NOT NULL,
	Godzina time(7), NOT NULL,
	Cena money, NOT NULL,
);
GO

CREATE TABLE dbo.Sala
(
	IdSala int NOT NULL,
	Nazwa varchar(100) NOT NULL,
	IloscMiejsc int NOT NULL,
);
GO
CREATE TABLE dbo.Film
(	IdFilm int NOT NULL,
	Tytul varchar(50) NOT NULL,
	Rok int NOT NULL,
	Dlugosc varchar(100) NOT NULL,
	Opis varchar(1000) NULL,
	IdKategoria [int] NOT NULL,
	Zwiastun varchar(100) NULL,
);
GO

CREATE TABLE dbo.Artysta(
	IdArtysta int NOT NULL,
	Imie varchar(50) NOT NULL,
	Nazwisko varchar(50) NOT NULL,
	FilmWeb varchar(100) NULL,
	);
	GO
CREATE TABLE dbo.ArtystaFilmowy(
	IdArtystaFilmowy int NOT NULL,
	IdFilm int NOT NULL,
	IdArtysta int NOT NULL,
	Rola varchar(50) NOT NULL,
	Opis varchar(50) NOT NULL,
	);
	GO
CREATE TABLE dbo.Kategoria(
	IdKategoria int NOT NULL,
	KategoriaNazwa varchar(50) NOT NULL,
	);
	GO
CREATE TABLE dbo.Wiadomosc(
	IdWiadomosc int NOT NULL,
	Imie varchar(50) NOT NULL,
	Temat varchar(100) NOT NULL,
	Tresc varchar(1000) NOT NULL,
	Data date NOT NULL,
	Mail varchar(50) NOT NULL,
	);
	GO
---Definicja kluczy g³ównych - Primary Key(PK).

ALTER TABLE dbo.Klient
ADD CONSTRAINT PK_Klient
PRIMARY KEY(IdKlient);
GO

ALTER TABLE dbo.Rezerwacja
ADD CONSTRAINT PK_Rezerwacja
PRIMARY KEY(IdRezerwacja);
GO

ALTER TABLE dbo.Bilet
ADD CONSTRAINT PK_Bilet
PRIMARY KEY(IdBilet);
GO

ALTER TABLE dbo.Seans
ADD CONSTRAINT PK_Seans
PRIMARY KEY(IdSeans);
GO

ALTER TABLE dbo.Sala
ADD CONSTRAINT PK_Sala
PRIMARY KEY(IdSala);
GO

ALTER TABLE dbo.Film
ADD CONSTRAINT PK_Film
PRIMARY KEY(IdFilm);
GO

ALTER TABLE dbo.Kategoria
ADD CONSTRAINT PK_Kategoria
PRIMARY KEY(IdKategoria);
GO

ALTER TABLE dbo.ArtystaFilmowy
ADD CONSTRAINT PK_ArtystaFilmowy
PRIMARY KEY(IdArtystaFilmowy);
GO

ALTER TABLE dbo.Artysta
ADD CONSTRAINT PK_Artysta
PRIMARY KEY(IdArtysta);
GO
--Definicja kluczy obcych
ALTER TABLE dbo.Rezerwacja
ADD CONSTRAINT FK_Rezerwacja_Klient
FOREIGN KEY (IdKlient)
REFERENCES dbo.Klient(IdKlient);
GO

ALTER TABLE dbo.Bilet
ADD CONSTRAINT FK_Bilet_Rezerwacja
FOREIGN KEY (IdRezerwacja)
REFERENCES dbo.Rezerwacja(IdRezerwacja);
GO

ALTER TABLE dbo.Bilet
ADD CONSTRAINT FK_Bilet_Seans
FOREIGN KEY (IdSeans)
REFERENCES dbo.Seans(IdSeans);
GO

ALTER TABLE dbo.Seans
ADD CONSTRAINT FK_Seans_Film
FOREIGN KEY (IdFilm)
REFERENCES dbo.Film(IdFilm);
GO

ALTER TABLE dbo.Seans
ADD CONSTRAINT FK_Seans_Sala
FOREIGN KEY (IdSala)
REFERENCES dbo.Sala(IdSala);
GO

ALTER TABLE dbo.Film
ADD CONSTRAINT FK_Film_Kategoria
FOREIGN KEY (IdKategoria)
REFERENCES dbo.Kategoria(IdKategoria);
GO

ALTER TABLE dbo.ArtystaFilmowy
ADD CONSTRAINT FK_ArtystaFilmowy_Film
FOREIGN KEY (IdFilm)
REFERENCES dbo.Film(IdFilm);
GO

ALTER TABLE dbo.ArtystaFilmowy
ADD CONSTRAINT FK_ArtystaFilmowy_Artysta
FOREIGN KEY (IdArtysta)
REFERENCES dbo.Artysta(IdArtysta);
GO
--Definicja ograniczen
ALTER TABLE dbo.Klient
ADD CONSTRAINT OK_Klient_KodPocztowy
CHECK (KodPocztowy LIKE '[0-9][0-9]-[0-9][0-9][0-9]');
GO

ALTER TABLE dbo.Rezerwacja
ADD CONSTRAINT OK_Rezerwacja_KwotaLaczna
CHECK (KwotaLaczna >=0);
GO

ALTER TABLE dbo.Bilet
ADD CONSTRAINT OK_Bilet_Cena
CHECK (Cena>=0);
GO


--Definicja wartosci domyslnych
ALTER TABLE dbo.Klient
ADD CONSTRAINT DF_Klient_Miejscowosc
DEFAULT ('Kalisz') FOR Miejscowosc;
GO

ALTER TABLE dbo.Rezerwacja
ADD CONSTRAINT DF_Rezerwacja_DataZlozenia
DEFAULT (GETDATE()) FOR DataZlozenia;
GO

ALTER TABLE dbo.Rezerwacja
ADD CONSTRAINT DF_Rezerwacja_KwotaLaczna
DEFAULT (0) FOR KwotaLaczna;
GO

--uniqe--------------------------------
ALTER TABLE dbo.Kategoria
ADD CONSTRAINT UN_KategoriaNazwa
UNIQUE(KategoriaNazwa);
GO

ALTER TABLE dbo.Artysta
ADD CONSTRAINT UN_ImieNazwisko
UNIQUE(Imie, Nazwisko);
GO

ALTER TABLE dbo.Klient
ADD CONSTRAINT UN_KlientPesel
UNIQUE(Pesel);
GO

ALTER TABLE dbo.Klient
ADD CONSTRAINT UN_KlientEmail
UNIQUE(E_mail);
GO

ALTER TABLE dbo.Bilet
ADD CONSTRAINT UN_BiletMiejsce
UNIQUE(Miejsce);
GO


---Zad 3-5
---Operacje CRUD-------------------
ALTER PROCEDURE dbo.Klient_wstaw
@Par_idKlient int,
@Par_Imie varchar(30),
@Par_Nazwisko varchar(50),
@Par_NrTel varchar(50),
@Par_PESEL int,
@Par_E_mail varchar(50)
AS
BEGIN

INSERT dbo.Klient
(IdKlient, Imie, Nazwisko, NrTel, PESEL, E_mail)
VALUES
(@Par_idKlient, @Par_Imie, @Par_Nazwisko, @Par_NrTel, @Par_PESEL, @Par_E_mail);
END;
GO
--------------------------------------------------------
---Wywo³anie procedury wariant pierwszy krótszy

EXECUTE dbo.Klient_wstaw 1, 'Ewelina', 'Klobut', '695236521', 902512645, 'klobute@gmail.com';
GO
EXECUTE dbo.Klient_wstaw 2, 'Agata', 'Lis', '562314523', 90122512645, 'agat@wp.pl';
GO
EXECUTE dbo.Klient_wstaw 3, 'Adam  ', 'Mordal ', '695236521 ', 90022512645, 'klobute@gmail.com';
GO
EXECUTE dbo.Klient_wstaw 4, ' Iga', 'Len', '695232521', 90112512645, 'len@gmail.com';
GO
EXECUTE dbo.Klient_wstaw 5, 'Jan', 'Kowal', '695536321',  922522645,  'kowal@gmail.com';
GO
EXECUTE dbo.Klient_wstaw 6, 'Igor ', 'Myszk', '677232521', 882512645, 'myszk@gmail.com';
GO
EXECUTE dbo.Klient_wstaw 7, 'Anna', 'Kêpka', '605695785 ', 941111502, 'kêpka@gmail.com';
GO
EXECUTE dbo.Klient_wstaw 8, 'Iza', 'Nowak', '680521425', 920250122, 'nowak@gmail.com';
GO
EXECUTE dbo.Klient_wstaw 9, 'Henryk', 'Luty', '524854652', 800205200 , 'luty@gmail.com';
GO
EXECUTE dbo.Klient_wstaw 10, 'Krystyna', 'Os¹d ', '501205321', 780315201, 'osad@gmail.com';
GO

----------------------------------------------
CREATE PROCEDURE dbo.Klient_zmien
@Par_idKlient int,
@Par_Imie varchar(30),
@Par_Nazwisko varchar(50),
@Par_NrTel varchar(50),
@Par_PESEL int,
@Par_Ulica varchar(50),
@Par_NrDomu varchar(10),
@Par_Miejscowosc varchar(10),
@Par_NrLokalu varchar(50),
@Par_KodPocztowy char(6),
@Par_E_mail varchar(50)
AS
BEGIN
UPDATE dbo.Klient
SET 
	Imie = @Par_Imie,
	Nazwisko = @Par_Nazwisko,
	NrTel = @Par_NrTel,
	PESEL = @Par_PESEL,
    E_mail=@Par_E_mail
WHERE idKlient = @Par_idKlient;
END;
GO
-------------------------------------------------

EXECUTE dbo.Klient_zmien 2, 'Agata', 'Nowak', '652314521', 510220210, 'nowak@wp.pl';
GO

------------------------------------------------
CREATE PROCEDURE dbo.Klient_usun
@Par_idKlient int
AS
BEGIN
DELETE dbo.Klient
WHERE idKlient = @Par_idKlient;
END;
GO
-------------------------------------------------------

EXECUTE dbo.Klient_usun 10;
GO

--------------------------------------------------------
--------------------------------------------------------
SELECT *
FROM dbo.Rezerwacja
GO

ALTER PROCEDURE dbo.Rezerwacja_wstaw
@Par_idRezerwacja int,
@Par_dataZlozenia date,
@Par_kwotaLaczna money,
@Par_idKlient int
AS
BEGIN
INSERT dbo.Rezerwacja
(IdRezerwacja, DataZlozenia, KwotaLaczna, IdKlient)
VALUES
(@Par_idRezerwacja, @Par_dataZlozenia, @Par_kwotaLaczna, @Par_idKlient);
END;
GO

EXECUTE dbo.Rezerwacja_wstaw 1, '2019-05-14', 12, 1;
GO
EXECUTE dbo.Rezerwacja_wstaw 2, '2017-05-20', 20, 1;
GO
EXECUTE dbo.Rezerwacja_wstaw 3, '2019-05-14', 30, 2;
GO
EXECUTE dbo.Rezerwacja_wstaw 4, '2019-05-12', 20, 3;
GO
EXECUTE dbo.Rezerwacja_wstaw 5, '2019-05-11', 26, 2;
GO
EXECUTE dbo.Rezerwacja_wstaw 6, '2019-05-10', 26, 3;
GO
EXECUTE dbo.Rezerwacja_wstaw 7, '2019-05-10', 21, 5;
GO
EXECUTE dbo.Rezerwacja_wstaw 8, '2019-05-14', 22, 6;
GO
EXECUTE dbo.Rezerwacja_wstaw 9, '2019-05-14', 23, 6;
GO
EXECUTE dbo.Rezerwacja_wstaw 10, '2019-05-13', 30, 7;
GO
EXECUTE dbo.Rezerwacja_wstaw 11, '2019-05-14', 35, 7;
GO
-------------------------------------------------
CREATE PROCEDURE dbo.Rezerwacja_zmien
@Par_idRezerwacja int, 
@Par_dataZlozenia date,
@Par_kwotaLaczna money,
@Par_idKlient int
AS
BEGIN
UPDATE dbo.Rezerwacja
SET dataZlozenia = @Par_dataZlozenia,
    kwotaLaczna=@Par_kwotaLaczna,
	IdKlient=@Par_idKlient
WHERE idRezerwacja = @Par_idRezerwacja;
END;
GO

/*
EXECUTE dbo.Rezerwacja_zmien  1, '2019-05-20', 60, 1;
GO
*/
-----------------------------------------------
CREATE PROCEDURE dbo.Rezerwacja_usun
@Par_idRezerwacja int
AS
BEGIN
DELETE dbo.Rezerwacja
WHERE idRezerwacja = @Par_idRezerwacja;
END;
GO
/*
EXECUTE dbo.Rezerwacja_usun 2;
GO
*/
SELECT *
FROM dbo.Rezerwacja
GO
-------------------------------------------
-----------------------------------------
SELECT *
FROM dbo.Artysta
GO

CREATE PROCEDURE dbo.Artysta_wstaw
@Par_idArtysta int,
@Par_imie varchar(50),
@Par_nazwisko varchar(50),
@Par_filmWeb varchar(100)
AS
BEGIN
INSERT dbo.Artysta
(IdArtysta, Imie, Nazwisko, FilmWeb)
VALUES
(@Par_idArtysta, @Par_imie, @Par_nazwisko, @Par_filmWeb);
END;
GO

EXECUTE  dbo.Artysta_wstaw  1, 'Frances', 'McDormand', 'https://www.filmweb.pl/person/Frances.Mcdormand';
GO
EXECUTE  dbo.Artysta_wstaw  2, 'Woody', 'Harrelson', 'https://www.filmweb.pl/person/Woody+Harrelson-44';
GO
EXECUTE  dbo.Artysta_wstaw  3, 'Peter ', 'Dinklage', 'https://www.filmweb.pl/person/Peter+Dinklage-3530';
GO
EXECUTE  dbo.Artysta_wstaw  4, 'Kristen', 'StewartChristian', 'https://www.filmweb.pl/person/Kristen+Stewart-52530';
GO
EXECUTE  dbo.Artysta_wstaw  5, 'Robert ', 'Pattinson';
GO
EXECUTE  dbo.Artysta_wstaw  6, 'Michael', 'Welch';
GO
EXECUTE  dbo.Artysta_wstaw  7, 'Tim', 'Robbins';
GO
EXECUTE  dbo.Artysta_wstaw  8, 'Morgan', 'Freeman';
GO
EXECUTE  dbo.Artysta_wstaw  9, 'Mark', 'Rolston';
GO
/*tu po jednym*/
EXECUTE  dbo.Artysta_wstaw  10, 'François', 'Cluzet';
GO
EXECUTE  dbo.Artysta_wstaw  11, 'Tom ', 'Hanks';
GO
EXECUTE  dbo.Artysta_wstaw  12, 'Donald ', 'Glover';
GO
EXECUTE  dbo.Artysta_wstaw  13, 'Ryan', 'Gosling';
GO
EXECUTE  dbo.Artysta_wstaw  14, 'Hayden', 'Christensen';
GO
EXECUTE  dbo.Artysta_wstaw  15, 'Edward', 'Norton';
GO
EXECUTE  dbo.Artysta_wstaw  16, 'Sigourney', 'Weaver';
GO



SELECT *
FROM dbo.Artysta
GO
----------------------------------
CREATE PROCEDURE dbo.Artysta_zmien
@Par_idArtysta int,
@Par_imie varchar(50),
@Par_nazwisko varchar(50),
@Par_filmWeb varchar(100)
AS
BEGIN
UPDATE dbo.Artysta
SET 
	Imie=@Par_imie,
	Nazwisko = @Par_nazwisko,
	FilmWeb=@Par_filmWeb 
		
WHERE IdArtysta = @Par_idArtysta;
END;
GO
/*
EXECUTE dbo.Artysta_zmien  5, 'Anna', 'Mucha', 'https://www.filmweb.pl/person/Anna.Mucha';
GO
*/
--------------------------------------
CREATE PROCEDURE dbo.Artysta_usun
@Par_idArtysta int
AS
BEGIN
DELETE dbo.Artysta
WHERE IdArtysta = @Par_idArtysta;
END;
GO
/*
EXECUTE dbo.Artysta_usun 5;
GO
*/
-------------------------------------------
-----------------------------------------
SELECT *
FROM dbo.Kategoria
GO

CREATE PROCEDURE dbo.Kategoria_wstaw
@Par_idKategoria int,
@Par_kategoriaNazwa varchar(50)
AS
BEGIN
INSERT dbo.Kategoria
(IdKategoria, KategoriaNazwa)
VALUES
(@Par_idKategoria, @Par_kategoriaNazwa);
END;
GO

EXECUTE  dbo.Kategoria_wstaw  1, 'obyczjowy';
GO
EXECUTE  dbo.Kategoria_wstaw  2, 'romantyczny';
GO
EXECUTE  dbo.Kategoria_wstaw  3, 'dokumentalny';
GO
EXECUTE  dbo.Kategoria_wstaw  4, 'animowany';
GO
EXECUTE  dbo.Kategoria_wstaw  5, 'horror';
GO
EXECUTE  dbo.Kategoria_wstaw  6, 'thriler';
GO
EXECUTE  dbo.Kategoria_wstaw  7, 'western';
GO
EXECUTE  dbo.Kategoria_wstaw  8, 'rozrywkowy';
GO
EXECUTE  dbo.Kategoria_wstaw  9, 'musical';
GO
EXECUTE  dbo.Kategoria_wstaw  10, 'dramat';
GO

SELECT *
FROM dbo.Kategoria
GO
----------------------------------
CREATE PROCEDURE dbo.Kategoria_zmien
@Par_kategoriaNazwa varchar(50)
AS
BEGIN
UPDATE dbo.Kategoria
SET 
	KategoriaNazwa=@Par_kategoriaNazwa
		
WHERE IdKategoria = @Par_kategoriaNazwa;
END;
GO
/*
EXECUTE dbo.Kategoria_zmien  5, 'Sci-fi';
GO
*/
--------------------------------------
CREATE PROCEDURE dbo.Kategoria_usun
@Par_idKategoria int
AS
BEGIN
DELETE dbo.Kategoria
WHERE IdKategoria = @Par_idKategoria;
END;
GO
/*
EXECUTE dbo.Kategoria_usun 5;
GO
*/
-----------------------------------------
-----------------------------------------
SELECT *
FROM dbo.Sala
GO

CREATE PROCEDURE dbo.Sala_wstaw
@Par_idSala int,
@Par_nazwa varchar(100),
@Par_iloscMiejsc int
AS
BEGIN
INSERT dbo.Sala
(IdSala, Nazwa, IloscMiejsc)
VALUES
(@Par_idSala, @Par_nazwa, @Par_iloscMiejsc);
END;
GO

EXECUTE  dbo.Sala_wstaw  1, '1', 100;
GO
EXECUTE  dbo.Sala_wstaw  2, '2', 200;
GO
EXECUTE  dbo.Sala_wstaw  3, '3', 230;
GO
EXECUTE  dbo.Sala_wstaw  4, '4', 310;
GO
EXECUTE  dbo.Sala_wstaw  5, '5', 250;
GO
EXECUTE  dbo.Sala_wstaw  6, '6', 220;
GO
EXECUTE  dbo.Sala_wstaw  7, '7', 150;
GO
EXECUTE  dbo.Sala_wstaw  8, '8', 180;
GO
EXECUTE  dbo.Sala_wstaw  9, '9', 220;
GO
EXECUTE  dbo.Sala_wstaw  10, '10', 180;
GO

----------------------------------
CREATE PROCEDURE dbo.Sala_zmien
@Par_idSala int,
@Par_nazwa varchar(100),
@Par_iloscMiejsc int
AS
BEGIN
UPDATE dbo.Sala
SET 
	Nazwa=@Par_nazwa,
	IloscMiejsc=@Par_iloscMiejsc
	
WHERE IdSala = @Par_idSala;
END;
GO
/*
EXECUTE dbo.Sala_zmien  10, '1K', 150;
GO
*/
--------------------------------------
CREATE PROCEDURE dbo.Sala_usun
@Par_idSala int
AS
BEGIN
DELETE dbo.Sala
WHERE IdSala = @Par_idSala;
END;
GO
/*
EXECUTE dbo.Sala_usun 10;
GO
*/
-----------------------------------------

-----------------------------------------
SELECT *
FROM dbo.Film
GO

ALTER PROCEDURE dbo.Film_wstaw
@Par_idFilm int,
@Par_tytul varchar(50),
@Par_rok int,
@Par_dlugosc varchar(100),
@Par_opis varchar(1000),
@Par_idKategoria int,
@Par_Zwiastun varchar(100)
AS
BEGIN
INSERT dbo.Film
(IdFilm, Tytul, Rok, Dlugosc, Opis, IdKategoria, Zwiastun)
VALUES
(@Par_idFilm, @Par_tytul, @Par_rok, @Par_dlugosc, @Par_opis, @Par_idKategoria, @Par_Zwiastun);
END;
GO

EXECUTE  dbo.Film_wstaw  1, 'Trzy billboardy za Ebbing, Missouri', 2017, '1 godz 55 min', 'Samotna matka, która straci³a córkê w wyniku morderstwa, wynajmuje trzy tablice reklamowe i umieszcza na nich prowokacyjny przekaz.', 10, 'https://www.youtube.com/watch?v=k1tU3Ivop_U';
GO
EXECUTE  dbo.Film_wstaw  2, 'Zmierzch', 2017, '1 godz 53 min', 'Auggie od urodzenia ma zdeformowan¹ twarz. W nowej szkole ch³opiec chce udowodniæ rówieœnikom, ¿e piêkno to wiêcej ni¿ wygl¹d.', 10, 'https://www.youtube.com/watch?v=tctr6NP_mQQ';
GO
EXECUTE  dbo.Film_wstaw  3, 'Skazani na Shawshank', 1994, '2 godz 22 min', 'Adaptacja opowiadania Stephena Kinga. Nies³usznie skazany na do¿ywocie bankier, stara siê przetrwaæ w brutalnym, wiêziennym œwiecie.', 10, 'https://www.youtube.com/watch?v=Yn7AD-MMNS4&t=1s';
GO
EXECUTE  dbo.Film_wstaw  4, 'Nietykalni', 2011, '1 godz 52 min', 'Sparali¿owany milioner zatrudnia do opieki m³odego ch³opaka z przedmieœcia, który w³aœnie wyszed³ z wiêzienia.', 10, 'https://www.youtube.com/watch?v=Iei_dJSEuNo';
GO
EXECUTE  dbo.Film_wstaw  5, 'Zielona mila', 1999, '3 godz 8 min', 'Emerytowany stra¿nik wiêzienny opowiada przyjació³ce o niezwyk³ym mê¿czyŸnie, którego skazano na œmieræ .', 10, 'https://www.youtube.com/watch?v=kRPhuj8f_3U';
GO
EXECUTE  dbo.Film_wstaw  6, 'Król Lew ', 1994, '1 godz 55 min', 'Targany nies³usznymi wyrzutami sumienia po œmierci ojca ma³y lew Simba skazuje siê na wygnanie, rezygnuj¹c z przynale¿nego mu miejsca na czele stada.', 4, 'https://www.youtube.com/watch?v=MTmjPXjtD_A';
GO
EXECUTE  dbo.Film_wstaw  7, 'Pamiêtnik', 2004, '2 godz 3 min', 'Stary mê¿czyzna czyta chorej na Alzheimera kobiecie pamiêtnik opisuj¹cy historiê mi³oœci dziewczyny z zamo¿nego domu i ubogiego pracownika tartaku. ', 1, 'https://www.youtube.com/watch?v=7pFX0TVf6sY';
GO
EXECUTE  dbo.Film_wstaw  8, 'Przebudzenia', 1990, '2 godz 1 min', 'Oparta na prawdziwych wydarzeniach opowieœæ o lekarzu, który za pomoc¹ eksperymentalnego leku przywraca³ do œwiadomoœci pogr¹¿onych w œpi¹czce pacjentów.', 10;
GO
EXECUTE  dbo.Film_wstaw  9, 'Podziemny kr¹g', 1990, '2 godz 19 min', 'Dwóch mê¿czyzn znudzonych rutyn¹ zak³ada klub, w którym co tydzieñ odbywaj¹ siê walki na go³e piêœci.', 6;
GO
EXECUTE  dbo.Film_wstaw  10, 'Obcy - 8. pasa¿er "Nostromo"', 1990, '1 godz 57 min', 'Za³oga statku kosmicznego Nostromo odbiera tajemniczy sygna³ i l¹duje na niewielkiej planetoidzie, gdzie jeden z jej cz³onków zostaje zaatakowany przez obc¹ formê ¿ycia.', 6;
GO

----------------------------------
CREATE PROCEDURE dbo.Film_zmien
@Par_idFilm int,
@Par_tytul varchar(50),
@Par_rok int,
@Par_dlugosc varchar(100),
@Par_opis varchar(1000),
@Par_idKategoria int, 
@Par_Zwiastun varchar(100)
AS
BEGIN
UPDATE dbo.Film
SET 
	Tytul=@Par_tytul,
	Rok=@Par_rok,
	Dlugosc=@Par_dlugosc,
	Opis=@Par_opis,
	IdKategoria=@Par_idKategoria,
	Zwiastun=@Par_Zwiastun
WHERE IdFilm = @Par_idFilm;
END;
GO
/*
EXECUTE dbo.Film_zmien  10, 'Obcy - 8. pasa¿er "Nostromo"', 1994, '1 godz 57 min', 'Za³oga statku kosmicznego Nostromo odbiera tajemniczy sygna³ i l¹duje na niewielkiej planetoidzie, gdzie jeden z jej cz³onków zostaje zaatakowany przez obc¹ formê ¿ycia.', 6;
GO
*/
--------------------------------------
CREATE PROCEDURE dbo.Film_usun
@Par_idFilm int
AS
BEGIN
DELETE dbo.Film
WHERE IdFilm = @Par_idFilm;
END;
GO
/*
EXECUTE dbo.Film_usun 10;
GO
*/
-----------------------------------------
-----------------------------------------
SELECT *
FROM dbo.ArtystaFilmowy
GO

ALTER PROCEDURE dbo.ArtystaFilmowy_wstaw
@Par_idArtystaFilmowy int,
@Par_idFilm int,
@Par_idArtysta int,
@Par_rola varchar(50),
@Par_opis varchar(50)
AS
BEGIN
INSERT dbo.ArtystaFilmowy
(IdArtystaFilmowy, IdFilm, IdArtysta, Rola, Opis)
VALUES
(@Par_idArtystaFilmowy, @Par_idFilm, @Par_idArtysta, @Par_rola, @Par_opis);
END;
GO

EXECUTE  dbo.ArtystaFilmowy_wstaw  1, 1, 1,'pierwszoplanowy', 'zalicza siê obecnie do najpopularniejszych i najlepiej zarabiaj¹cych aktorek Hollywood, jednak w m³odoœci nie planowa³a kariery artystycznej, ale medyczn¹.'; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  2, 1, 2,'pierwszoplanowy', 'Dzieciñstwo Harrelsona nie nale¿a³o do szczêœliwych. Jego ojciec zosta³ skazany na do¿ywotnie wiezienie za zabójstwo sêdziego a Woody'; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  3, 1, 3,'drugoplanowy', 'zacz¹³ graæ w pi¹tej klasie, gdy zagra³ g³ówn¹ rolê w przedstawieniu 'The Velveteen Rabbit'. W 1991 roku ukoñczy³ studia w Bennington Collage '; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  4, 2, 4,'pierwszoplanowy', 'brytyjski aktor filmowy i telewizyjny, producent filmowy. Laureat Oscara za drugoplanow¹ rolê mêsk¹ w filmie Fighter w 2010 roku'; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  5, 2, 5,'pierwszoplanowy', 'od najm³odszych lat by³ œwietnym sportowcem, ³apa³ siê dos³ownie ka¿dego sportu, od pi³ki no¿nej a¿ po snowboarding'; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  6, 2, 6,'drugoplanowy', 'brytyjski aktor filmowy i telewizyjny, producent filmowy. Laureat Oscara za drugoplanow¹ rolê mêsk¹ w filmie Fighter w 2010 roku'; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  7, 3, 7,'drugoplanowy', ' to niezwykle ciekawa postaæ - aktor, nale¿¹cy do m³odego pokolenia, który zd¹¿y³ ju¿ zas³yn¹æ jako scenarzysta, uhonorowany Oscarem i Z³otym Globem.'; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  8, 3, 8,'drugoplanowy', ' urodzi³ siê 25 lipca 1987 roku w Los Angeles. Jego debiutem by³a rola w serialu ...'; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  9, 3, 9,'drugoplanowy', ' amerykañski aktor filmowy, telewizyjny i g³osowy, prawdopodobnie najbardziej znany z roli Bogsa '; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  10, 4, 10,'pierwszoplanowy', ' amerykañski aktor, scenarzysta, re¿yser, producent filmowy i muzyk, najlepiej znany z roli Andy’ego Dufresne'; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  11, 4, 11,'pierwszoplanowy', 'Dzisiaj uwa¿any jest za jednego z najwybitniejszych aktorów kina amerykañskiego. Jednak ma³o kto wie, i¿ zaczyna³ pracê jako goniec w dziale kreskówek'; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  12, 5, 12,'pierwszoplanowy', 'urodzi³ siê 5 stycznia 1975 roku w Filadelfii (Pensylwania, USA). Jeszcze jako m³ody ch³opak postanowi³, ¿e w przysz³oœci zostanie aktorem.'; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  13, 6, 13,'pierwszoplanowy', 'urodzi³ siê w Hayward 2 maja 1972 roku. Jego ojciec, Rocky, by³ profesjonalnym wrestlerem, dziêki czemu m³ody Dwayne czêsto podró¿owa³.'; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  14, 7, 14,'pierwszoplanowy', 'ur. 26 kwietnia 1980 w Warszawie) – aktor, prezenterka telewizyjna i celebrytka.'; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  15, 8, 15,'pierwszoplanowy', 'amerykañska aktorka, piosenkarka popowa, tancerka, projektantka mody, producentka i businesswoman. Urodzi³a siê i wychowa³a w Bronksie'; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  16, 9, 16,'pierwszoplanowy', 'zalicza siê obecnie do najpopularniejszych i najlepiej zarabiaj¹cych aktorek Hollywood, jednak w m³odoœci nie planowa³a kariery artystycznej, ale medyczn¹.'; 
GO
EXECUTE  dbo.ArtystaFilmowy_wstaw  17, 10, 17,'pierwszoplanowy', 'urodzi³a siê 8 paŸdziernika 1949 roku w Nowym Jorku (Nowy Jork, USA). Wywodzi siê z rodziny aktorskiej,'; 
GO

----------------------------------
CREATE PROCEDURE dbo.ArtystaFilmowy_zmien
@Par_idArtystaFilmowy int,
@Par_idFilm int,
@Par_idArtysta int,
@Par_rola varchar(50),
@Par_opis varchar(50)
AS
BEGIN
UPDATE dbo.ArtystaFilmowy
SET 
	IdArtystaFilmowy=@Par_idArtystaFilmowy,
	IdFilm=@Par_idFilm,
	IdArtysta=@Par_idArtysta,
	Rola=@Par_rola,
	Opis=@Par_opis
	
WHERE IdArtystaFilmowy = @Par_idArtystaFilmowy;
END;
GO
/*
EXECUTE dbo.ArtystaFilmowy_zmien  11, 4, 6,'pierwszoplanowy', 'zalicza siê obecnie do najpopularniejszych i najlepiej zarabiaj¹cych aktorek Hollywood, jednak w m³odoœci nie planowa³a kariery artystycznej, ale medyczn¹.'; 
GO
*/
--------------------------------------
CREATE PROCEDURE dbo.ArtystaFilmowy_usun
@Par_idArtystaFilmowy int
AS
BEGIN
DELETE dbo.ArtystaFilmowy
WHERE IdArtystaFilmowy = @Par_idArtystaFilmowy;
END;
GO
/*
EXECUTE dbo.ArtystaFilmowy_usun 11;
GO
*/
-----------------------------------------
-----------------------------------------
SELECT *
FROM dbo.Seans
GO

CREATE PROCEDURE dbo.Seans_wstaw
@Par_idSeans int,
@Par_idFilm int,
@Par_dataGodzina date,
@Par_IdSala int,
@Par_Godzina time(7), 
@Par_Cena money
AS
BEGIN
INSERT dbo.Seans
(IdSeans, IdFilm, DataGodzina, IdSala, Godzina, Cena)
VALUES
(@Par_idSeans, @Par_idFilm, @Par_dataGodzina, @Par_IdSala, @Par_Godzina, @Par_Cena);
END;
GO

EXECUTE  dbo.Seans_wstaw  1, 3, '2019-06-25', 1, '18:30', 20; 
GO
EXECUTE  dbo.Seans_wstaw  2, 5, '2019-07-1', 2, '19:30', 22; 
GO
EXECUTE  dbo.Seans_wstaw  3, 4, '2019-07-2', 3, '19:30', 19; 
GO
EXECUTE  dbo.Seans_wstaw  4, 1, '2019-06-27',  5, '20:30', 20; 
GO
EXECUTE  dbo.Seans_wstaw  5, 2, '2019-06-28', 4, '21:30', 22; 
GO
EXECUTE  dbo.Seans_wstaw  6, 3, '2019-06-29', 6, '22:30', 20; 
GO
EXECUTE  dbo.Seans_wstaw  7, 8, '2019-07-1', 8, '19:30', 18; 
GO
EXECUTE  dbo.Seans_wstaw  8, 9, '2019-07-27',  7, '18:30', 20; 
GO
EXECUTE  dbo.Seans_wstaw  9, 10, '2019-06-28', 10, '18:30', 25; 
GO
EXECUTE  dbo.Seans_wstaw  11, 7, '2019-06-30', 9, '17:30', 23;
GO

----------------------------------
CREATE PROCEDURE dbo.Seans_zmien
@Par_idSeans int,
@Par_idFilm int,
@Par_dataGodzina date,
@Par_IdSala int
AS
BEGIN
UPDATE dbo.Seans
SET 
	IdFilm=@Par_idFilm,
	DataGodzina=@Par_dataGodzina,
	IdSala=@Par_IdSala

WHERE IdSeans = @Par_idSeans;
END;
GO
/*
EXECUTE dbo.Seans_zmien  11, 7, '2019-05-19', 9;
GO
*/
--------------------------------------
CREATE PROCEDURE dbo.Seans_usun
@Par_idSeans int
AS
BEGIN
DELETE dbo.Seans
WHERE IdSeans = @Par_idSeans;
END;
GO
/*
EXECUTE dbo.Seans_usun 11;
GO
*/
-----------------------------------------
-----------------------------------------
SELECT *
FROM dbo.Bilet
GO

ALTER PROCEDURE dbo.Bilet_wstaw
@Par_idBilet int,
@Par_idRezerwacja int,
@Par_idSeans int,
@Par_miejsce varchar(10)
AS
BEGIN
INSERT dbo.Bilet
(IdBilet, IdRezerwacja, IdSeans, Miejsce)
VALUES
(@Par_idBilet, @Par_idRezerwacja, @Par_idSeans, @Par_miejsce);
END;
GO

EXECUTE  dbo.Bilet_wstaw  1, 3, 10, '12a'; 
GO
EXECUTE  dbo.Bilet_wstaw  2, 5, 2, '15'; 
GO
EXECUTE  dbo.Bilet_wstaw  3, 4, 3, '10'; 
GO
EXECUTE  dbo.Bilet_wstaw  4, 1, 4, '9'; 
GO
EXECUTE  dbo.Bilet_wstaw  5, 2, 1, '13'; 
GO
EXECUTE  dbo.Bilet_wstaw  6, 3, 6, '14'; 
GO
EXECUTE  dbo.Bilet_wstaw  7, 8, 5, '12'; 
GO
EXECUTE  dbo.Bilet_wstaw  8, 9, 8, '2'; 
GO
EXECUTE  dbo.Bilet_wstaw  9, 10, 7, '26'; 
GO
EXECUTE  dbo.Bilet_wstaw  10, 7, 9, '51';
GO
EXECUTE  dbo.Bilet_wstaw  11, 7, 9, '25';
GO
EXECUTE  dbo.Bilet_wstaw  10, 7, 9,  '51';
GO

----------------------------------
CREATE PROCEDURE dbo.Bilet_zmien
@Par_idBilet int,
@Par_idRezerwacja int,
@Par_idSeans int,
@Par_miejsce varchar(10)
AS
BEGIN
UPDATE dbo.Bilet
SET 
	IdBilet=@Par_idBilet,
	IdRezerwacja=@Par_idRezerwacja,
	IdSeans=@Par_idSeans,
	Miejsce=@Par_miejsce

WHERE IdBilet = @Par_idBilet;
END;
GO
/*
EXECUTE dbo.Bilet_zmien  11, 7, 5, '30', 30;;
GO
*/
--------------------------------------
CREATE PROCEDURE dbo.Bilet_usun
@Par_idBilet int
AS
BEGIN
DELETE dbo.Bilet
WHERE IdBilet = @Par_idBilet;
END;
GO

EXECUTE dbo.Bilet_usun 11;
GO

----LISTA C5 KINO
------ TRANSAKCJE------------------------

------------------------------------------
------ ARCHIWIZACJA
------------------------------------------

CREATE TABLE dbo.Klient_Archiwum
(
	IdKlient int NOT NULL,
	Imie varchar(30) NOT NULL,
	Nazwisko varchar(30) NOT NULL,
	NrTel varchar(20) NOT NULL,
	Pesel int NOT NULL,
	Ulica varchar(30) NULL,
	NrDomu int NOT NULL,
	Miejscowosc varchar(30) NOT NULL,
	NrLokalu int NULL,
	KodPocztowy char(6) NOT NULL,
	E_mail varchar(50) NOT NULL,
	DataArchiwizacji date NOT NULL,
);
GO

CREATE PROCEDURE dbo.Klient_Archiwizuj
@Par_IDKlient int
AS
BEGIN


-- PRZERWANIE WYKONANIA I WYCOFANIE TRANSAKCJI BEZPOŒREDNIO
-- PO WYST¥PIENIU B£ÊDU CZASU WYKONANIA (runtime error)
SET XACT_ABORT ON;
BEGIN TRANSACTION

-- KOPIOWANIE DANYCH UCZESTNIKA

INSERT dbo.Klient_Archiwum(IdKlient, Imie, Nazwisko, NrTel, Pesel, Ulica, NrDomu, Miejscowosc, NrLokalu, KodPocztowy, E_mail, DataArchiwizacji)
SELECT IdKlient, Imie, Nazwisko, NrTel, Pesel, E_mail, GETDATE()
FROM dbo.Klient
WHERE IdKlient = @Par_IdKlient;


-- Testowe zatrzymanie transakcji.
WAITFOR DELAY '00:00:15';


-------------------------------------------------
-- (2) Usuniecie danych klienta z tabeli [Klient].
DELETE dbo.Klient
WHERE IdKlient = @Par_IdKlient;

IF (@@ERROR <> 0)
BEGIN
	RAISERROR('Archiwizowanie danych klienta nie powiod³o siê!', 16, 1);
	ROLLBACK TRANSACTION
END
ELSE
	COMMIT TRANSACTION
END;
GO


------- PRZYK£ADOWE WYWO£ANIE
SELECT *
FROM dbo.Klient;
GO

EXECUTE dbo.Klient_Archiwizuj 
@Par_IdKlient = 9;
GO

SELECT *
FROM dbo.Klient;
GO

SELECT *
FROM dbo.Klient_Archiwum;
GO



-- SLEDZENIE ZMAIN CEN
-- ---------------
CREATE TABLE dbo.ProduktCenaHistoria
(
IdBiletCenaHistoria int NOT NULL PRIMARY KEY IDENTITY(1,1),
IdCena int NOT NULL, ---produkt którego cena jest sledzona
CenaPoprzednia money NOT NULL, ------Nowa cena
CenaNowa money NOT NULL,
DataZmiany datetime NOT NULL ----data i giodzina zmiany ceny
);
GO

SELECT *
FROM dbo.ProduktCenaHistoria;
GO

CREATE PROCEDURE dbo.Seans_Cena_Zmien
@Par_IdSeans int,
@Par_CenaNowa money
AS
BEGIN


-- PO WYST¥PIENIU B£ÊDU CZASU WYKONANIA (runtime error)
SET XACT_ABORT ON;
DECLARE @Var_CenaPoprzednia money;

BEGIN TRANSACTION --- pocztake bloku transakcji

SELECT @Var_CenaPoprzednia= Cena
FROM dbo.Seans
WHERE IdSeans = @Par_IdSeans;

-- Testowe zatrzymanie transakcji.
WAITFOR DELAY '00:00:15';

IF (@Par_CenaNowa<>@Var_CenaPoprzednia)
BEGIN
	UPDATE dbo.Seans
	SET Cena=@Par_CenaNowa
	WHERE IdSeans=@Par_IdSeans

	INSERT dbo.ProduktCenaHistoria(IdCena, CenaPoprzednia,  CenaNowa, DataZmiany)
	VALUES
	(@Par_IdSeans, @Var_CenaPoprzednia, @Par_CenaNowa, GETDATE());
END


IF (@@ERROR <> 0)
	ROLLBACK TRANSACTION
ELSE
	COMMIT TRANSACTION
END;
GO

------- PRZYK£ADOWE WYWO£ANIE
SELECT *
FROM dbo.Seans;
GO

EXECUTE dbo.Seans_Cena_Zmien 
@Par_IdSeans=3, 
@Par_CenaNowa= 20;
GO

SELECT *
FROM dbo.Seans;
GO

SELECT *
FROM dbo.ProduktCenaHistoria;
GO


-----------------------------------------------------------------------
---------------------------------------------------------------------------
CREATE PROCEDURE dbo.KlienciRezerwacja
@Par_DataOd date='2019-05-01',
@Par_DataDo date='2019-05-30',
@Par_minWartosc money =0.00
AS
BEGIN -- Kolumny [KodPrzedmiotu] i [Forma] maj¹ zmienione nag³ówki przez AS.
SELECT dbo.Klient.IdKlient, Imie, Nazwisko, 
		COUNT(*) AS [LiczbaRezerwacji],
		SUM(KwotaLaczna) AS [Kwota£¹czna]
FROM dbo.Klient
	INNER JOIN dbo.Rezerwacja
	ON dbo.Klient.IdKlient=dbo.Rezerwacja.IdKlient
WHERE DataZlozenia BETWEEN @Par_DataOd AND @Par_DataDo
GROUP BY dbo.Klient.IdKlient, Imie, Nazwisko
HAVING SUM(KwotaLaczna) >= @Par_minWartosc
ORDER BY [Kwota£¹czna] DESC, [LiczbaRezerwacji] DESC; -- Sortowanie malej¹co
END;
GO

EXECUTE dbo.KlienciRezerwacja
GO

------------------------------------------------------------
----Ile sprzedanych biletów
---------------------------------------
CREATE PROCEDURE dbo.FilmSprzedaneBilety
--@Par_CenaWieksz=20
AS
BEGIN 
SELECT Tytul,
		COUNT(*) AS [LiczbaBiletow]
		
FROM dbo.Film
	INNER JOIN dbo.Seans
	ON dbo.Film.IdFilm=dbo.Seans.IdFilm
		INNER JOIN dbo.Bilet
		ON dbo.Seans.IdSeans=dbo.Bilet.IdSeans
GROUP BY Tytul
ORDER BY LiczbaBiletow DESC
END;
GO

EXECUTE dbo.FilmSprzedaneBilety
GO
------------------------------
-----------------------------------------
-------filmy danej kategorii
-------------------------------
ALTER PROCEDURE dbo.FilmDanejKategorii
AS
BEGIN 
SELECT KategoriaNazwa,
		COUNT(dbo.Film.IdFilm) AS [LiczbaFilmów]
		
FROM dbo.Kategoria
	INNER JOIN dbo.Film
	ON dbo.Kategoria.IdKategorii=dbo.Film.IdKategoria
		
GROUP BY KategoriaNazwa
ORDER BY LiczbaFilmów DESC
END;
GO

EXECUTE dbo.FilmDanejKategorii
GO

---------------------------------------------
-----Wyswietlenie filmów które s¹ puszacne od jakiejs daty
ALTER PROCEDURE [dbo].[WyswFilmy]
@Par_DataOd date = '2016-01-01',
@Par_DataDo date = '2100-12-31'
AS
BEGIN
SELECT IdSeansu, DataGodzina, Tytul
            FROM dbo.Seans
            INNER JOIN dbo.Film 
            ON dbo.Seans.IdFilm=dbo.Film.IdFilm
			WHERE DataGodzina BETWEEN @Par_DataOd AND @Par_DataDo
ORDER BY DataGodzina ASC;
END;

EXECUTE dbo.WyswFilmy
GO



--DO STRONY INTERNETOWEJ
SELECT Tytul, KategoriaNazwa, Rok, Dlugosc, Opis, Nazwa AS [Nazwa sali]
            FROM dbo.Seans
				 INNER JOIN dbo.Sala 
				ON dbo.Seans.IdSala=dbo.Sala.IdSala
					INNER JOIN dbo.Film 
					ON dbo.Seans.IdFilm=dbo.Film.IdFilm
						 INNER JOIN dbo.Kategoria
						ON dbo.Film.IdKategoria=dbo.Kategoria.IdKategoria
			WHERE DataGodzina BETWEEN '2016-01-01' AND '2021-01-01'
ORDER BY DataGodzina ASC;
--------------------------------------
SELECT IdFilm, Tytul, Rok, Dlugosc, Opis, KategoriaNazwa
            FROM dbo.Film
            INNER JOIN dbo.Kategoria 
            ON dbo.Film.IdKategoria=dbo.Kategoria.IdKategoria;
----------------------------------------------
SELECT Tytul, KategoriaNazwa, Rok, Dlugosc, Opis, Nazwa AS [Nazwa sali]
            FROM dbo.Seans
				 INNER JOIN dbo.Sala 
				ON dbo.Seans.IdSala=dbo.Sala.IdSala
					INNER JOIN dbo.Film 
					ON dbo.Seans.IdFilm=dbo.Film.IdFilm
						 INNER JOIN dbo.Kategoria
						ON dbo.Film.IdKategoria=dbo.Kategoria.IdKategoria
            WHERE dbo.Seans.IdSeans=1;
--------------------------------------------------------
			SELECT Tytul, KategoriaNazwa, Rok, Dlugosc, Opis, Nazwa AS [Nazwasali]
            FROM dbo.Seans
				 INNER JOIN dbo.Sala 
				ON dbo.Seans.IdSala=dbo.Sala.IdSala
					INNER JOIN dbo.Film 
					ON dbo.Seans.IdFilm=dbo.Film.IdFilm
						 INNER JOIN dbo.Kategoria
						ON dbo.Film.IdKategoria=dbo.Kategoria.IdKategoria
            WHERE dbo.Seans.IdSeans=2;
-------------------------------------------------------
			SELECT Tytul, KategoriaNazwa, Rok, Film.Opis, Dlugosc, Nazwa, DataGodzina, Cena
            FROM dbo.Seans
				 INNER JOIN dbo.Sala 
				ON dbo.Seans.IdSala=dbo.Sala.IdSala
				INNER JOIN dbo.Bilet 
				ON dbo.Bilet.IdSeans=dbo.Seans.IdSeans
					INNER JOIN dbo.Film 
					ON dbo.Film.IdFilm=dbo.Seans.IdFilm
						INNER JOIN dbo.Kategoria
						ON dbo.Film.IdKategoria=dbo.Kategoria.IdKategoria
            WHERE dbo.Seans.IdSeans=6;

-------------------wszystkie filmy
			SELECT dbo.Film.IdFilm, Tytul, DataGodzina
                FROM dbo.Film
                INNER JOIN dbo.Seans
                ON dbo.Seans.IdFilm=dbo.Film.IdFilm;

-------------film--szczegoly
			SELECT Film.IdFilm,DataGodzina, Cena, Sala.Nazwa, Tytul, Godzina, IdSeans
            FROM dbo.Film
				INNER JOIN dbo.Seans
				ON dbo.Film.IdFilm=Seans.IdFilm
				INNER JOIN dbo.Sala
				ON dbo.Sala.IdSala=Seans.IdSala
            WHERE dbo.Film.IdFilm=3;
-------------------------------------------
			SELECT Tytul, KategoriaNazwa, Rok, Opis, Dlugosc
			FROM.dbo.Film
			INNER JOIN dbo.Kategoria
				ON dbo.Film.IdKategoria=dbo.Kategoria.IdKategoria
            WHERE dbo.Film.IdFilm=3;

--------------------------------------------
	SELECT Imie, Nazwisko
	From dbo.Film
	INNER JOIN dbo.ArtystaFilmowy
				ON dbo.ArtystaFilmowy.IdFilm=dbo.Film.IdFilm
				INNER JOIN dbo.Artysta
				ON dbo.Artysta.IdArtysta=dbo.ArtystaFilmowy.IdArtysta
	WHERE dbo.Film.IdFilm=1;
--------------------------------------------
	SELECT IdSeans, DataGodzina, Tytul
                FROM dbo.Seans
                INNER JOIN dbo.Film 
                ON dbo.Seans.IdFilm=dbo.Film.IdFilm;
-------------------------------------------
	SELECT Tytul, KategoriaNazwa, Rok, Film.Opis, Dlugosc, Cena
            FROM dbo.Seans
				 INNER JOIN dbo.Sala 
				ON dbo.Seans.IdSala=dbo.Sala.IdSala
				INNER JOIN dbo.Bilet 
				ON dbo.Bilet.IdSeans=dbo.Seans.IdSeans
					INNER JOIN dbo.Film 
					ON dbo.Film.IdFilm=dbo.Seans.IdFilm
						INNER JOIN dbo.Kategoria
						ON dbo.Film.IdKategoria=dbo.Kategoria.IdKategoria
            WHERE dbo.Seans.IdSeans=$IdSeans;
/*
ALTER TABLE dbo.Seans
 ADD Cena money;

  ALTER TABLE dbo.Klient
DROP COLUMN KodPocztowy;

ALTER TABLE dbo.Klient
DROP CONSTRAINT OK_Klient_KodPocztowy;
*/
SELECT DataGodzina, Cena, Sala.Nazwa, Tytul, Godzina, IdSeans
            FROM dbo.Seans
				INNER JOIN dbo.Film
				ON dbo.Film.IdFilm=Seans.IdFilm
				INNER JOIN dbo.Sala
				ON dbo.Sala.IdSala=Seans.IdSala
            WHERE dbo.Seans.IdSeans=2;

			SELECT IdKlient, Imie,Nazwisko, NrTel, Pesel, E_mail
            FROM dbo.Klient;
        

		SELECT DataGodzina, Cena, Nazwa, Tytul, Godzina, IdSeans
            FROM dbo.Seans
				INNER JOIN dbo.Film
				ON dbo.Film.IdFilm=Seans.IdFilm
				INNER JOIN dbo.Sala
				ON dbo.Sala.IdSala=Seans.IdSala
            WHERE dbo.Seans.IdSeans=5;
-----------------------
----filmy wieksze niz 20 z³
/*
CREATE PROCEDURE dbo.FilmSprzedaneBilety
@Par_CenaWieksz int =20
AS
BEGIN 
SELECT Tytul,
		COUNT(*) AS [LiczbaBiletow]
		
FROM dbo.Film
	INNER JOIN dbo.Seans
	ON dbo.Film.IdFilm=dbo.Seans.IdFilm
		INNER JOIN dbo.Bilet
		ON dbo.Seans.IdSeansu=dbo.Bilet.IdSeans
	
HAVING SUM(Cena) >= @Par_CenaWieksz
--GROUP BY Cena
ORDER BY [Cena] DESC
--END;
GO

EXECUTE dbo.FilmSprzedaneBilety
GO*/