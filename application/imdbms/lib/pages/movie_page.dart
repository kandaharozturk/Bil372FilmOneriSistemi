import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:imdbms/controllers/db.dart';
import 'package:imdbms/entities/Film.dart';
import 'package:imdbms/entities/diger_kullanici.dart';
import 'package:imdbms/imdbms_icon.dart';
import 'package:imdbms/movie_card.dart';
import 'package:imdbms/my_app_bar.dart';
import 'package:imdbms/pages/home_page.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    final filmID = ModalRoute.of(context)!.settings.arguments as int?;
    final Color yelloish = Colors.yellow.shade200;
    late Film? film;
    late List<DigerKullanici>? digerKullanicilar;
    DB db = DB();
    Future<void> setFilmInfo() async {
      film = await db.getFilmInfo(filmID ?? -1, db.userID ?? -1);
      digerKullanicilar =
          await db.getOtherUsersWatched(filmID ?? -1, db.userID ?? -1);
    }

    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: MyAppBar(controller: controller),
        leading: ImdbmsIcon(),
        leadingWidth: 120,
      ),
      body: FutureBuilder(
          future: setFilmInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 320,
                              height: 500,
                              decoration: BoxDecoration(
                                  color: Colors.yellow.shade200,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            Gap(12),
                            Container(
                              width: 300,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Gap(16),
                                        Text("Beğen"),
                                        IconButton(
                                            onPressed: () async {
                                              setState(() {
                                                if (film?.begendiMi ?? false) {
                                                  db.begenme(filmID ?? -1,
                                                      db.userID ?? -1);
                                                } else {
                                                  db.begen(filmID ?? -1,
                                                      db.userID ?? -1);
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              Icons.favorite,
                                              color: film?.begendiMi ?? false
                                                  ? Colors.red
                                                  : Colors.white,
                                              size: 16,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          film?.izlediMi ?? false
                                              ? "İzledim"
                                              : "İzlemedim",
                                          style: TextStyle(
                                              color: film?.izlediMi ?? false
                                                  ? Colors.green
                                                  : Colors.white),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              setState(() {
                                                if (film?.izlediMi ?? false) {
                                                  db.izleme(filmID ?? -1,
                                                      db.userID ?? -1);
                                                } else {
                                                  db.izledim(filmID ?? -1,
                                                      db.userID ?? -1);
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              Icons.checklist_rtl_sharp,
                                              color: film?.izlediMi ?? false
                                                  ? Colors.green
                                                  : Colors.white,
                                              size: 16,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(16),
                            film?.izlediMi ?? false
                                ? Container(
                                    width: 200,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Text(
                                              "İzleme Tarihi: ${film?.izlemeTarihi}"),
                                        ),
                                        Divider(
                                          color: yelloish,
                                          thickness: 1,
                                        )
                                      ],
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                        Gap(16),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          film?.ad ?? "isimsiz film",
                                          style: TextStyle(fontSize: 32),
                                        ),
                                        Gap(16),
                                        Row(
                                          children: List.generate(
                                              film?.genre?.length ?? 0,
                                              (index) {
                                            return GenreBox(
                                                genre: film?.genre![index] ??
                                                    "isimsiz genre");
                                          }),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 120,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Popülerlik: ${film?.populerlik}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Divider(
                                            thickness: 1,
                                            color: Colors.yellow.shade200,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Gap(16),
                                    Container(
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Text(
                                            "imDBMS: ${film?.puan}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Divider(
                                            thickness: 1,
                                            color: Colors.yellow.shade200,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Gap(32),
                                AutoSizeText(
                                  film?.filmAciklamasi ?? "aciklama yok",
                                  minFontSize: 16,
                                ),
                                Gap(32),
                                Container(
                                  width: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Oyuncular",
                                          style: TextStyle(fontSize: 24),
                                        ),
                                        Divider(
                                          color: yelloish,
                                          thickness: 1,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Gap(16),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        film?.oyuncular?.length ?? 0, (index) {
                                      return ActorCard(
                                          name: film?.oyuncular?[index] ??
                                              "isimsiz actor");
                                    }),
                                  ),
                                ),
                                Gap(40),
                                Container(
                                  width: 400,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Bu Filmi İzleyen Diğer Kullanıcılar",
                                          style: TextStyle(fontSize: 24),
                                        ),
                                        Divider(
                                          color: yelloish,
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1200,
                                  height: 3000,
                                  child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 6,
                                              crossAxisSpacing: 8,
                                              childAspectRatio: 2,
                                              mainAxisSpacing: 8),
                                      itemCount: digerKullanicilar?.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onDoubleTap: () async {
                                            await Navigator.pushNamed(
                                                context, "/userprofile",
                                                arguments:
                                                    digerKullanicilar?[index]
                                                        .kullaniciID);
                                          },
                                          child: Container(
                                            width: 80,
                                            height: 20,
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  foregroundColor: yelloish,
                                                  backgroundColor: yelloish,
                                                  radius: 20,
                                                ),
                                                Gap(16),
                                                Center(
                                                  child: Column(
                                                    children: [
                                                      Gap(16),
                                                      AutoSizeText(
                                                        "${digerKullanicilar?[index].ad} ${digerKullanicilar?[index].soyad ?? "soyad yok"}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      AutoSizeText(
                                                        digerKullanicilar?[
                                                                    index]
                                                                .kullaniciAdi ??
                                                            "kullanici adi yok",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class ActorCard extends StatelessWidget {
  const ActorCard({
    required this.name,
    super.key,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    final Color yelloish = Colors.yellow.shade200;

    return InkWell(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            width: 150,
            height: 250,
            decoration: BoxDecoration(
                color: yelloish, borderRadius: BorderRadius.circular(4)),
          ),
          Gap(8),
          Text(name)
        ],
      ),
    );
  }
}

class GenreBox extends StatelessWidget {
  const GenreBox({
    required this.genre,
    super.key,
  });

  final String genre;

  @override
  Widget build(BuildContext context) {
    final Color yelloish = Colors.yellow.shade200;
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(4),
      child: Text(genre),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: yelloish),
          borderRadius: BorderRadius.circular(32)),
    );
  }
}
