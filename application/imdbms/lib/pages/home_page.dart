// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:imdbms/controllers/db.dart';
import 'package:imdbms/entities/Film.dart';
import 'package:imdbms/imdbms_icon.dart';
import 'package:imdbms/movie_card.dart';
import 'package:imdbms/my_app_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController controller = TextEditingController();

  final Color yelloish = Colors.yellow.shade700;
  DB db = DB();
  late List<Film> popularFilms;
  late List<Film> recommendedFilms;

  Future<void> setPopularAndRecommendedFilms() async {
    popularFilms = await db.getPopularFilms(db.userID ?? -1) ?? List.empty();
    recommendedFilms =
        await db.setRecommendedFilms1(db.userID ?? -1) ?? List.empty();

    if (recommendedFilms.isEmpty) {
      recommendedFilms =
          await db.setRecommendedFilms2(db.userID ?? -1) ?? List.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userID = ModalRoute.of(context)!.settings.arguments as int?;
    return FutureBuilder(
        future: setPopularAndRecommendedFilms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ));
          }
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 120,
              leading: ImdbmsIcon(),
              title: MyAppBar(
                controller: controller,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 40, right: 8, top: 40, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 280,
                      child: Column(
                        children: [
                          Text(
                            "Popular Films",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                          ),
                          Divider(
                            color: yelloish,
                            thickness: 2,
                            indent: 4,
                          )
                        ],
                      ),
                    ),
                    Gap(32),
                    Container(
                      height: 320,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              popularFilms.length,
                              (index) => MovieCard(
                                    filmID: popularFilms[index].filmID ?? -1,
                                    name: popularFilms[index].ad ?? "unnamed",
                                    point: popularFilms[index].puan ?? -1,
                                    like:
                                        popularFilms[index].begendiMi ?? false,
                                    wathced:
                                        popularFilms[index].izlediMi ?? false,
                                  )),
                        ),
                      ),
                    ),
                    Gap(40),
                    Container(
                      width: 320,
                      child: Column(
                        children: [
                          Text(
                            "Recommended Films",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                          ),
                          Divider(
                            color: yelloish,
                            thickness: 2,
                            indent: 4,
                          )
                        ],
                      ),
                    ),
                    Gap(32),
                    Container(
                      height: 320,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              recommendedFilms.length,
                              (index) => MovieCard(
                                    filmID:
                                        recommendedFilms[index].filmID ?? -1,
                                    name:
                                        recommendedFilms[index].ad ?? "unnamed",
                                    point: recommendedFilms[index].puan ?? -1,
                                    like: recommendedFilms[index].begendiMi ??
                                        false,
                                    wathced:
                                        popularFilms[index].izlediMi ?? false,
                                  )),
                        ),
                      ),
                    ),
                    Gap(24)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
