create database FilmVeritabani;


create table Kullanici(
	KullaniciID varchar(20) not NULL,
	Mail varchar(50) not NULL,
	Sifre varchar(20) not NULL,
	KullaniciAdi varchar(20) not NULL,
	Adi varchar(20) not NULL,
	Soyadi varchar(20) not NULL,
	primary KEY(KullaniciID)
);

create table Film(
	FilmID varchar(20) not NULL,
	Ad varchar(50) not NULL,
	FilmAciklamasi varchar(255),
	Puan int,
	Populerlik int,
	primary KEY(FilmID)
);

create table Oyuncular(
	FilmID varchar(20) not NULL,
	Oyuncu varchar(50) not NULL,
	primary key(FilmID,Oyuncu),
	foreign key(FilmID) references Film(FilmID)
);

create table PopulerFilmListesi(
	FilmID varchar(20) not NULL,
	primary key(FilmID),
	foreign key(FilmID) references Film(FilmID)
);

create table OneriFilmListesi(
	KullaniciID varchar(20) not NULL,
	FilmID varchar(20) not NULL,
	primary key(KullaniciID,FilmID),
	foreign key(KullaniciID) references Kullanici(KullaniciID),
	foreign key(FilmID) references Film(FilmID)
);


create table Icerir(
	KullaniciID varchar(20) not NULL,
	FilmID varchar(20) not NULL,
	primary key(KullaniciID,FilmID),
	foreign key(KullaniciID) references Kullanici(KullaniciID),
	foreign key(FilmID) references Film(FilmID)
);

create table Genre(
	GenreAdi varchar(20) not NULL,
	primary key(GenreAdi)
);

create table TercihEder(
	KullaniciID varchar(20) not NULL,
	GenreAdi varchar(20) not NULL,
	primary key(KullaniciID,GenreAdi),
	foreign key(KullaniciID) references Kullanici(KullaniciID),
	foreign key(GenreAdi) references Genre(GenreAdi)
);

create table Izler(
	KullaniciID varchar(20) not NULL,
	FilmID varchar(20) not NULL,
	IzlemeTarihi date not NULL,
	primary key(KullaniciID,FilmID),
	foreign key(KullaniciID) references Kullanici(KullaniciID),
	foreign key(FilmID) references Film(FilmID)
);

create table Begenir(
	KullaniciID varchar(20) not NULL,
	FilmID varchar(20) not NULL,
	BegenmeTarihi date not NULL,
	primary key(KullaniciID,FilmID),
	foreign key(KullaniciID) references Kullanici(KullaniciID),
	foreign key(FilmID) references Film(FilmID)
);

create table Aittir(
	FilmID varchar(20) not NULL,
	GenreAdi varchar(20) not NULL,
	primary key(FilmID,GenreAdi),
	foreign key(FilmID) references Film(FilmID),
	foreign key(GenreAdi) references Genre(GenreAdi)
);




