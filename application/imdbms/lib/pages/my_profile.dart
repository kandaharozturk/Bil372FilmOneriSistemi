import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:imdbms/imdbms_icon.dart';
import 'package:imdbms/movie_card.dart';
import 'package:imdbms/my_app_bar.dart';
import 'package:imdbms/pages/movie_page.dart';

class MyProfile extends StatelessWidget {
  MyProfile({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Color yelloish = Colors.yellow.shade200;

    return Scaffold(
      appBar: AppBar(
        title: MyAppBar(controller: controller),
        leading: ImdbmsIcon(),
        leadingWidth: 120,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(),
                Text(
                  "Ömer Kalaylı",
                  style: TextStyle(fontSize: 32),
                ),
                Text(
                  "Theoden",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Gap(40),
                Container(
                    width: 200,
                    child: Container(
                        child: Column(
                      children: [
                        Text(
                          "Tercih Edilen Genrelar",
                          style: TextStyle(fontSize: 20),
                        ),
                        Divider(
                          color: yelloish,
                          thickness: 1,
                        )
                      ],
                    ))),
                GenreBox(genre: "Aksiyon"),
                GenreBox(genre: "Bilim Kurgu"),
                GenreBox(genre: "Tarih"),
                GenreBox(genre: "Komedi"),
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ))
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
                                "İzlenen Filmler",
                                style: TextStyle(fontSize: 24),
                              ),
                              Divider(
                                color: yelloish,
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                MovieCard(
                                  filmID: 1,
                                  name: "Game of Thrones",
                                  point: 9.3,
                                  showIcons: false,
                                ),
                                MovieCard(
                                  filmID: 1,
                                  name: "Harry Potter",
                                  point: 5.5,
                                  showIcons: false,
                                ),
                                MovieCard(
                                  filmID: 1,
                                  name: "Marslı",
                                  point: 8.9,
                                  showIcons: false,
                                ),
                                MovieCard(
                                  filmID: 1,
                                  name: "Marslı",
                                  point: 8.9,
                                  showIcons: false,
                                ),
                                MovieCard(
                                  filmID: 1,
                                  name: "Marslı",
                                  point: 8.9,
                                  showIcons: false,
                                ),
                                MovieCard(
                                  filmID: 1,
                                  name: "Marslı",
                                  point: 8.9,
                                  showIcons: false,
                                ),
                                MovieCard(
                                  filmID: 1,
                                  name: "Marslı",
                                  point: 8.9,
                                  showIcons: false,
                                ),
                                MovieCard(
                                  filmID: 1,
                                  name: "Marslı",
                                  point: 8.9,
                                  showIcons: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(20),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 200,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Beğenilen Filmler",
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Divider(
                                        color: yelloish,
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        MovieCard(
                                          filmID: 1,
                                          name: "Game of Thrones",
                                          point: 9.3,
                                          showIcons: false,
                                        ),
                                        MovieCard(
                                          filmID: 1,
                                          name: "Harry Potter",
                                          point: 5.5,
                                          showIcons: false,
                                        ),
                                        MovieCard(
                                          filmID: 1,
                                          name: "Marslı",
                                          point: 8.9,
                                          showIcons: false,
                                        ),
                                        MovieCard(
                                          filmID: 1,
                                          name: "Marslı",
                                          point: 8.9,
                                          showIcons: false,
                                        ),
                                        MovieCard(
                                          filmID: 1,
                                          name: "Marslı",
                                          point: 8.9,
                                          showIcons: false,
                                        ),
                                        MovieCard(
                                          filmID: 1,
                                          name: "Marslı",
                                          point: 8.9,
                                          showIcons: false,
                                        ),
                                        MovieCard(
                                          filmID: 1,
                                          name: "Marslı",
                                          point: 8.9,
                                          showIcons: false,
                                        ),
                                        MovieCard(
                                          filmID: 1,
                                          name: "Marslı",
                                          point: 8.9,
                                          showIcons: false,
                                        ),
                                      ],
                                    ),
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
      ),
    );
  }
}
