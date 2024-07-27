// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:imdbms/controllers/db.dart';
import 'package:imdbms/pages/auth_page.dart';
import 'package:imdbms/pages/home_page.dart';
import 'package:imdbms/pages/movie_page.dart';
import 'package:imdbms/pages/my_profile.dart';
import 'package:imdbms/pages/search_page.dart';
import 'package:imdbms/pages/user_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  final DB db = DB();
  db.createDB();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'imDBMS',
        routes: {
          "/home": (context) => HomePage(),
          "/auth": (context) => AuthPage(),
          "/movie": (context) => MoviePage(),
          "/myprofile": (context) => MyProfile(),
          "/userprofile": (context) => UserProfile(),
          "/search": (context) => SearchPage()
        },
        theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))))),
            primaryColor: Colors.yellow,
            textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
            scaffoldBackgroundColor: Color.fromARGB(255, 23, 23, 23),
            appBarTheme: AppBarTheme(
              centerTitle: false,
              toolbarHeight: 72,
              backgroundColor: Colors.black,
            )),
        home: AuthPage());
  }
}
