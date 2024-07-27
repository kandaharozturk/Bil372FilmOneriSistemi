import 'package:imdbms/entities/Film.dart';
import 'package:imdbms/entities/diger_kullanici.dart';
import 'package:imdbms/entities/kullanici.dart';
import 'package:intl/intl.dart';
import 'package:mysql_client/mysql_client.dart';

class DB {
  static final DB _instance = DB._internal();

  MySQLConnectionPool? db;
  int? userID;
  factory DB() {
    return _instance;
  }
  DB._internal();

  void createDB() {
    db = MySQLConnectionPool(
        host: '10.0.2.2',
        port: 3306,
        userName: 'root',
        password: '1327',
        maxConnections: 10,
        databaseName: 'project');
  }

  Future<bool> register(String email, String sifre, String kullaniciAdi,
      String adi, String soyadi) async {
    try {
      if (db == null) {
        throw Exception("db is null");
      }
      await db!.execute(
        "INSERT INTO Kullanici (Mail, Sifre, KullaniciAdi, Adi, Soyadi) VALUES (:Mail, :Sifre, :KullaniciAdi, :Adi, :Soyadi)",
        {
          "Mail": email,
          "Sifre": sifre,
          "KullaniciAdi": kullaniciAdi,
          "Adi": adi,
          "Soyadi": soyadi
        },
      );

      var response2 = await db!.execute(
          "select KullaniciID from Kullanici where Mail = :Mail",
          {"Mail": email});
      userID =
          int.parse(response2.first.rows.first.assoc()['KullaniciID'] ?? "-1");
      userID = userID;
      return true;
    } catch (e) {
      print("Kayıt işlemi sırasında bir hata oluştu. Hata $e");
      return false;
    }
  }

  Future<int> signIn(String email, String sifre) async {
    try {
      var result = await db!.execute(
          "select KullaniciID from Kullanici where Mail = :Mail AND Sifre = :Sifre",
          {"Mail": email, "Sifre": sifre});
      var response2 = await db!.execute(
          "select KullaniciID from Kullanici where Mail = :Mail",
          {"Mail": email});
      userID =
          int.parse(response2.first.rows.first.assoc()['KullaniciID'] ?? "-1");
      userID = userID;
      return int.parse(result.first.rows.first.assoc()['KullaniciID'] ?? "-1");
    } catch (e) {
      print("Giriş sirasnda hata! $e");
      return -1;
    }
  }

  Future<List<Film>?> getPopularFilms(int userID) async {
    try {
      var result = await db!.execute(
          "select p.filmID, f.ad, f.filmAciklamasi, f.populerlik, f.puan, Exists (select * from Begenir as b where b.KullaniciID = :userID and b.FilmID = p.FilmID) as begendiMi, Exists (select * from izler as i where i.KullaniciID = :userID and i.FilmID = p.FilmID) as izlediMi from PopulerFilmListesi as p natural join film as f order by f.populerlik desc",
          {"userID": userID});
      List<Film> popularFilms = List.empty(growable: true);
      for (var film in result.rows) {
        Map<String, String?> val = film.assoc();
        Film temp = Film(
            ad: val.values.elementAt(1),
            filmAciklamasi: val.values.elementAt(2),
            filmID: int.parse(val.values.elementAt(0) ?? "-1"),
            populerlik: double.parse(val.values.elementAt(3) ?? "-1"),
            puan: double.parse(val.values.elementAt(4) ?? "-1"),
            begendiMi: (val.values.elementAt(5) ?? 0) == "0" ? false : true,
            izlediMi: (val.values.elementAt(6) ?? 0) == "0" ? false : true);
        popularFilms.add(temp);
      }
      return popularFilms;
    } catch (e) {
      print("hata $e");
    }
  }

  Future<List<Film>?> getRecommendedFilms(int userID) async {
    try {
      var result = await db!.execute(
          "select p.filmID, f.ad, f.filmAciklamasi, f.populerlik, f.puan, Exists (select * from Begenir as b where b.KullaniciID = :userID and b.FilmID = p.FilmID) as begendiMi, Exists (select * from izler as i where i.KullaniciID = :userID and i.FilmID = p.FilmID) as izlediMi from OneriFilmListesi as p natural join film as f order by f.populerlik desc",
          {"userID": userID});
      List<Film> recommendedFilms = List.empty(growable: true);
      for (var film in result.rows) {
        Map<String, String?> val = film.assoc();
        Film temp = Film(
            ad: val.values.elementAt(1),
            filmAciklamasi: val.values.elementAt(2),
            filmID: int.parse(val.values.elementAt(0) ?? "-1"),
            populerlik: double.parse(val.values.elementAt(3) ?? "-1"),
            puan: double.parse(val.values.elementAt(4) ?? "-1"),
            begendiMi: (val.values.elementAt(5) ?? 0) == "0" ? false : true,
            izlediMi: (val.values.elementAt(6) ?? 0) == "0" ? false : true);
        recommendedFilms.add(temp);
      }
      return recommendedFilms;
    } catch (e) {
      print("hata $e");
    }
  }

  Future<List<Film>?> getSearchedFilms(String text) async {
    try {
      var response = await db!.execute(
          "select ad,filmid,puan from film where ad like :text",
          {"text": "%$text%"});

      List<Film> searchedFilms = List.empty(growable: true);
      for (var film in response.rows) {
        Map<String, String?> val = film.assoc();
        Film temp = Film(
          ad: val.values.elementAt(0),
          filmID: int.parse(val.values.elementAt(1) ?? "-1"),
          puan: double.parse(val.values.elementAt(2) ?? "-1"),
        );

        searchedFilms.add(temp);
      }
      return searchedFilms;
    } catch (e) {
      print("hataa $e");
    }
  }

  Future<Film?> getFilmInfo(int filmID, int userID) async {
    try {
      var oyuncular = await db!.execute(
          "select Oyuncu from Oyuncular where FilmID = :filmID",
          {"filmID": filmID});
      List<String> oyuncuList = List.empty(growable: true);
      for (var oyuncu in oyuncular.rows) {
        Map<String, String?> val = oyuncu.assoc();
        oyuncuList.add(val.values.elementAt(0) ?? "unnamed");
      }
      var genre = await db!.execute(
          "select genreAdi from Aittir where FilmID = :filmID",
          {"filmID": filmID});
      List<String> genreList = List.empty(growable: true);
      for (var temp in genre.rows) {
        Map<String, String?> val = temp.assoc();
        genreList.add(val.values.elementAt(0) ?? "unnamed genre");
      }
      var response = await db!.execute(
          "select p.filmID, f.ad, f.filmAciklamasi, f.populerlik, f.puan, (select izlemeTarihi from Izler where KullaniciID = :userID and FilmID = p.FilmID) as izlemeTarihi, Exists (select * from Begenir as b where b.KullaniciID = :userID and b.FilmID = p.FilmID) as begendiMi, Exists (select * from izler as i where i.KullaniciID = :userID and i.FilmID = p.FilmID) as izlediMi from OneriFilmListesi as p natural join film as f where p.filmID = :filmID order by f.populerlik desc",
          {"userID": userID, "filmID": filmID});

      var film = response.rows.first;
      Map<String, String?> val = film.assoc();
      Film temp = Film(
          ad: val.values.elementAt(1),
          filmID: int.parse(val.values.elementAt(0) ?? "-1"),
          filmAciklamasi: val.values.elementAt(2),
          populerlik: double.parse(val.values.elementAt(3) ?? "-1"),
          puan: double.parse(val.values.elementAt(4) ?? "-1"),
          begendiMi: (val.values.elementAt(6) ?? 0) == "0" ? false : true,
          izlediMi: (val.values.elementAt(7) ?? 0) == "0" ? false : true,
          izlemeTarihi: val.values.elementAt(5),
          genre: genreList,
          oyuncular: oyuncuList);
      return temp;
    } catch (e) {
      print("hataa $e");
    }
  }

  Future<void>? begen(int filmID, int userID) async {
    try {
      DateTime now = DateTime.now();

      // Tarih formatını belirle
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');

      // Tarihi formatla
      String formattedDate = dateFormat.format(now);
      var response = await db!.execute(
          "insert into begenir (KullaniciID, FilmID, BegenmeTarihi) values (:userID, :filmID, :date)",
          {"userID": userID, "filmID": filmID, "date": formattedDate});
    } catch (e) {
      print("begenemdin $e");
    }
  }

  Future<void>? begenme(int filmID, int userID) async {
    try {
      var response = await db!.execute(
          "Delete from begenir where KullaniciID = :userID and FilmID = :filmID",
          {"userID": userID, "filmID": filmID});
    } catch (e) {
      print("begenemdin $e");
    }
  }

  Future<void>? izledim(int filmID, int userID) async {
    try {
      DateTime now = DateTime.now();

      // Tarih formatını belirle
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');

      // Tarihi formatla
      String formattedDate = dateFormat.format(now);
      var response = await db!.execute(
          "insert into izler (KullaniciID, FilmID, IzlemeTarihi) values (:userID, :filmID, :date)",
          {"userID": userID, "filmID": filmID, "date": formattedDate});
    } catch (e) {
      print("izleyemedin $e");
    }
  }

  Future<void>? izleme(int filmID, int userID) async {
    try {
      var response = await db!.execute(
          "Delete from izler where KullaniciID = :userID and FilmID = :filmID",
          {"userID": userID, "filmID": filmID});
    } catch (e) {
      print("izlemedin $e");
    }
  }

  Future<List<Film?>?> getWatchedFilms(int userID) async {
    try {
      var response = await db!.execute(
          "select FilmID from izler where KullaniciID = :userID",
          {"userID": userID});
      List<Film?> izlenenFilmler = List.empty(growable: true);
      for (var temp in response.rows) {
        Map<String, String?> val = temp.assoc();
        izlenenFilmler.add(await getFilmInfo(
            int.parse(val.values.elementAt(0) ?? "-1"), userID));
      }
      return izlenenFilmler;
    } catch (e) {
      print("couldnt get wathched films: $e");
    }
  }

  Future<List<Film?>?> getLikedFilms(int userID) async {
    try {
      var response = await db!.execute(
          "select FilmID from begenir where KullaniciID = :userID",
          {"userID": userID});
      List<Film?> begenilenFilmler = List.empty(growable: true);
      for (var temp in response.rows) {
        Map<String, String?> val = temp.assoc();
        begenilenFilmler.add(await getFilmInfo(
            int.parse(val.values.elementAt(0) ?? "-1"), userID));
      }
      return begenilenFilmler;
    } catch (e) {
      print("couldnt get liked films: $e");
    }
  }

  Future<List<String>?> getPrefferedGenres(int userID) async {
    try {
      var reponse = await db!.execute(
          "select genreAdi from TercihEder where KullaniciID = :userID",
          {"userID": userID});
      List<String> tercihEdilenGenrelar = List.empty(growable: true);
      for (var genre in reponse.rows) {
        tercihEdilenGenrelar
            .add(genre.assoc().values.elementAt(0) ?? "undefined genre name");
      }
      return tercihEdilenGenrelar;
    } catch (e) {
      print("couldnt get genres: $e");
    }
  }

  Future<Kullanici?> getUserInfo(int userID) async {
    try {
      List<Film?>? likedFilms = await getLikedFilms(userID);
      List<Film?>? watchedFilms = await getWatchedFilms(userID);
      var response = await db!.execute(
          "select Adi, Soyadi, KullaniciAdi, Mail from Kullanici where KullaniciID = :userID",
          {"userID": userID});
      return Kullanici(
          izlenenFilmler: watchedFilms,
          begenilenFilmler: likedFilms,
          ad: response.rows.first.assoc().values.elementAt(0),
          soyad: response.rows.first.assoc().values.elementAt(1),
          kullaniciAdi: response.rows.first.assoc().values.elementAt(2),
          mail: response.rows.first.assoc().values.elementAt(3),
          tercihEdilenGenrelar: await getPrefferedGenres(userID));
    } catch (e) {
      print("couldnt get user info: $e");
    }
  }

  Future<List<DigerKullanici>?> getOtherUsersWatched(
      int filmID, int userID) async {
    try {
      var response = await db!.execute(
          "select k.KullaniciID, k.Adi, k.Soyadi, k.KullaniciAdi from Kullanici as k natural join izler as i where i.FilmID = :filmID",
          {"filmID": filmID});
      List<DigerKullanici> digerKullaniciList = List.empty(growable: true);
      for (var kullanici in response.rows) {
        int otherID = int.parse(kullanici.assoc().values.elementAt(0) ?? "-1");
        if (otherID == userID) {
          continue;
        }
        digerKullaniciList.add(DigerKullanici(
          kullaniciID: int.parse(kullanici.assoc().values.elementAt(0) ?? "-1"),
          ad: kullanici.assoc().values.elementAt(1),
          soyad: kullanici.assoc().values.elementAt(2),
          kullaniciAdi: kullanici.assoc().values.elementAt(3),
        ));
      }
      return digerKullaniciList;
    } catch (e) {
      print("cant get other users: $e");
    }
  }
  // Future<void> getTuples() async {
  //   try {
  //     var result = await db?.execute("SELECT * from Kullanici");
  //     for (ResultSetRow row in result?.rows ?? []) {
  //       print(row.assoc());
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
