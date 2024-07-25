--GIRIŞ EKRANI

--Kullanıcı kayıt olduğunda girdiği tüm bilgilerin "Kullanıcı" tablosuna eklenmesi.


insert into Kullanici (mail,Sifre,KullaniciAdi,Adi,Soyadi)
values('Mail(String)','Sifre(String)','KullaniciAdi(String)','Adi(String)','Soyadi(String)');

--Kullanıcı giriş yaptığında girdiği kullanıcı adına göre verilerin getirilmesi ve şifre ile eşlenmesi

select kullaniciadi, sifre
from kullanici
where kullaniciadi='Girilen kullanici adi' and sifre='Girilen sifre';

--ANA EKRAN

--Popüler film tablosunun popülerliği en yüksek olandan en düşük olana göre getirilmesi.

select f.Ad,
from populerfilmlistesi as p 
natural join film as f
order by f.populerlik desc;

--ARAMA EKRANI

--Filmlerin adına göre içinde "kullanıcı girdisi" geçenlerin getirilmesi.(filmId filme tıklandığında doğru sayfayı açmak için)

select ad,filmid
from film
where ad like 'Girdi%';

--FILM EKRANI(filmId sayfa açıldığında tutmak lazım)(filmid=0, kullaniciid=1)

--Ekran ilk açıldığında açılan film id'sine göre tüm film verisini döndür.

select ad,filmaciklamasi,puan,populerlik
from film
where filmid=0;

--Filmin genre bilgisini getir.

select genreadi
from genre
natural join aittir
natural join film as f
where f.filmid=0;

--Kullanıcı filmi izlediyse filmi izleme tarihinin getirilmesi.

select izlemetarihi
from izler
natural join film as f
natural join kullanici as k
where f.filmid=0 and k.kullaniciid=1;

--Kullanıcı filmi beğendiğinde beğenir tablosunda yeni bir satır oluştur.

insert into begenir
values(1,0,now());


--Kullanıcı filmi izlediğinde izler tablosunda yeni bir satır oluştur.

insert into izler
values(1,0,now());

--Beğeniyi kaldırma

delete from begenir
where kullaniciid=1 and filmid=0;

--İzlemeyi kaldırma

delete from izler 
where kullaniciid=1 and filmid=0;



