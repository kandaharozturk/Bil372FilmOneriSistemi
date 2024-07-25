create table Kullanici(
	KullaniciID SERIAL not null,
	Mail varchar(50) not NULL,
	Sifre varchar(20) not NULL,
	KullaniciAdi varchar(20) not null unique,
	Adi varchar(20) not NULL,
	Soyadi varchar(20) not NULL,
	primary KEY(KullaniciID)
);

create table Film(
	FilmID SERIAL not NULL,
	Ad varchar(50) not NULL,
	FilmAciklamasi varchar(255),
	Puan int,
	Populerlik int,
	primary KEY(FilmID)
);

create table Oyuncular(
	FilmID int not NULL,
	Oyuncu varchar(50) not NULL,
	primary key(FilmID,Oyuncu),
	foreign key(FilmID) references Film(FilmID)
);


create table PopulerFilmListesi(
	FilmID int not NULL,
	primary key(FilmID),
	foreign key(FilmID) references Film(FilmID)
);

create table OneriFilmListesi(
	KullaniciID int not NULL,
	FilmID int not NULL,
	primary key(KullaniciID,FilmID),
	foreign key(KullaniciID) references Kullanici(KullaniciID),
	foreign key(FilmID) references Film(FilmID)
);


create table Icerir(
	KullaniciID int not NULL,
	FilmID int not NULL,
	primary key(KullaniciID,FilmID),
	foreign key(KullaniciID) references Kullanici(KullaniciID),
	foreign key(FilmID) references Film(FilmID)
);

create table Genre(
	GenreAdi varchar(20) not NULL,
	primary key(GenreAdi)
);

create table TercihEder(
	KullaniciID int not NULL,
	GenreAdi varchar(20) not NULL,
	primary key(KullaniciID,GenreAdi),
	foreign key(KullaniciID) references Kullanici(KullaniciID),
	foreign key(GenreAdi) references Genre(GenreAdi)
);

create table Izler(
	KullaniciID int not NULL,
	FilmID int not NULL,
	IzlemeTarihi date not NULL,
	primary key(KullaniciID,FilmID),
	foreign key(KullaniciID) references Kullanici(KullaniciID),
	foreign key(FilmID) references Film(FilmID)
);

create table Begenir(
	KullaniciID int not NULL,
	FilmID int not NULL,
	BegenmeTarihi date not NULL,
	primary key(KullaniciID,FilmID),
	foreign key(KullaniciID) references Kullanici(KullaniciID),
	foreign key(FilmID) references Film(FilmID)
);

create table Aittir(
	FilmID int not NULL,
	GenreAdi varchar(20) not NULL,
	primary key(FilmID,GenreAdi),
	foreign key(FilmID) references Film(FilmID),
	foreign key(GenreAdi) references Genre(GenreAdi)
);