class Film {
  Film(
      {this.filmID,
      this.ad,
      this.filmAciklamasi,
      this.populerlik,
      this.puan,
      this.begendiMi,
      this.izlediMi,
      this.izlemeTarihi,
      this.genre,
      this.oyuncular});

  int? filmID;
  String? ad;
  String? filmAciklamasi;
  double? puan;
  double? populerlik;
  bool? begendiMi;
  bool? izlediMi;
  String? izlemeTarihi;
  List<String>? genre;
  List<String>? oyuncular;
}
