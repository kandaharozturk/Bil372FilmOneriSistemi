import 'package:imdbms/entities/Film.dart';

class Kullanici {
  Kullanici(
      {this.kullaniciAdi,
      this.ad,
      this.kullaniciID,
      this.mail,
      this.sifre,
      this.soyad,
      this.izlenenFilmler,
      this.begenilenFilmler,
      this.tercihEdilenGenrelar});

  int? kullaniciID;
  String? mail;
  String? sifre;
  String? kullaniciAdi;
  String? ad;
  String? soyad;
  List<Film?>? izlenenFilmler;
  List<Film?>? begenilenFilmler;
  List<String>? tercihEdilenGenrelar;
}
