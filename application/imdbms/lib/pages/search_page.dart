import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:imdbms/controllers/db.dart';
import 'package:imdbms/entities/Film.dart';
import 'package:imdbms/imdbms_icon.dart';
import 'package:imdbms/movie_card.dart';
import 'package:imdbms/my_app_bar.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final TextEditingController controller = TextEditingController();
  late List<Film> searchedFilms;
  DB db = DB();

  Future<void> setSearchedFilms(String filmName) async {
    searchedFilms = await db.getSearchedFilms(filmName) ?? List.empty();
  }

  @override
  Widget build(BuildContext context) {
    final filmName = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
        appBar: AppBar(
          leading: ImdbmsIcon(),
          leadingWidth: 120,
          title: MyAppBar(controller: controller),
        ),
        body: FutureBuilder(
            future: setSearchedFilms(filmName ?? ""),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              }
              return Column(
                children: [
                  Gap(8),
                  Text(
                    "${searchedFilms.length.toString()} film bulundu.",
                    style: TextStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.5,
                                  crossAxisCount: 8,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 0),
                          itemCount: searchedFilms.length,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              filmID: searchedFilms[index].filmID ?? -1,
                              name: searchedFilms[index].ad ?? "",
                              point: searchedFilms[index].puan ?? -1,
                              showIcons: false,
                            );
                          }),
                    ),
                  ),
                ],
              );
            }));
  }
}
