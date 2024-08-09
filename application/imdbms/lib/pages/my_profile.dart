import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:imdbms/controllers/db.dart';
import 'package:imdbms/entities/kullanici.dart';
import 'package:imdbms/imdbms_icon.dart';
import 'package:imdbms/movie_card.dart';
import 'package:imdbms/my_app_bar.dart';
import 'package:imdbms/pages/movie_page.dart';

class MyProfile extends StatefulWidget {
  MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController controller = TextEditingController();

  DB db = DB();

  late Kullanici? user;

  Future<void> setUserInfo(int userID) async {
    user = await db.getUserInfo(userID);
  }

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Color yelloish = Colors.yellow.shade200;
    final userID = db.userID ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: MyAppBar(controller: controller),
        leading: ImdbmsIcon(),
        leadingWidth: 120,
      ),
      body: FutureBuilder(
          future: setUserInfo(userID ?? -1),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(),
                      Text(
                        ("${user?.ad} ${user?.ad ?? ""}") ?? "no name",
                        style: TextStyle(fontSize: 32),
                      ),
                      Text(
                        user?.kullaniciAdi ?? "no nick",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Gap(40),
                      Container(
                          width: 200,
                          child: Container(
                              child: Column(
                            children: [
                              Text(
                                "Preffered Genres",
                                style: TextStyle(fontSize: 20),
                              ),
                              Divider(
                                color: yelloish,
                                thickness: 1,
                              )
                            ],
                          ))),
                      Column(
                        children: List.generate(
                            user?.tercihEdilenGenrelar?.length ?? 0, (index) {
                          return GenreBox(
                              genre: user?.tercihEdilenGenrelar?[index] ??
                                  "unnamed genre");
                        }),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 40,
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              controller: textEditingController,
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                setState(() {
                                  db.addGPrefferedGenre(
                                      userID, textEditingController.text);
                                  textEditingController.text = "";
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ],
                  ),
                  Gap(40),
                  Expanded(
                    child: Container(
                      width: 300,
                      child: SingleChildScrollView(
                        child: Container(
                          width: 1000,
                          height: 1000,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                child: Column(
                                  children: [
                                    Text(
                                      "Wathced Films",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    Divider(
                                      color: yelloish,
                                      thickness: 1,
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      user?.izlenenFilmler?.length ?? 0,
                                      (index) {
                                    return MovieCard(
                                        showIcons: false,
                                        filmID: user?.izlenenFilmler?[index]
                                                ?.filmID ??
                                            -1,
                                        name:
                                            user?.izlenenFilmler?[index]?.ad ??
                                                "adsiz",
                                        point: user?.izlenenFilmler?[index]
                                                ?.puan ??
                                            -1);
                                  }),
                                ),
                              ),
                              Gap(20),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Column(
                                          children: [
                                            Text(
                                              "Liked Films",
                                              style: TextStyle(fontSize: 24),
                                            ),
                                            Divider(
                                              color: yelloish,
                                              thickness: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(
                                              user?.begenilenFilmler?.length ??
                                                  0, (index) {
                                            return MovieCard(
                                                showIcons: false,
                                                filmID: user
                                                        ?.begenilenFilmler?[
                                                            index]
                                                        ?.filmID ??
                                                    -1,
                                                name: user
                                                        ?.begenilenFilmler?[
                                                            index]
                                                        ?.ad ??
                                                    "adsiz",
                                                point: user
                                                        ?.begenilenFilmler?[
                                                            index]
                                                        ?.puan ??
                                                    -1);
                                          }),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(20),
                ],
              ),
            );
          }),
    );
  }
}
