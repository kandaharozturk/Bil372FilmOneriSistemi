// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:imdbms/controllers/db.dart';
import 'package:imdbms/imdbms_icon.dart';
import 'package:imdbms/my_app_bar.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final Color yelloish = Colors.yellow.shade700;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

  DB db = DB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 120,
        leading: ImdbmsIcon(),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Gap(60),
                Text(
                  "imDBMS'e Giriş Yap",
                  style: TextStyle(fontSize: 36),
                ),
                Gap(40),
                CustomTextField(
                    title: "Mail Adresi", controller: emailController),
                CustomTextField(title: "Şifre", controller: passwordController),
                Gap(20),
                Center(
                    child: SizedBox(
                  width: 200,
                  height: 48,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(yelloish)),
                      onPressed: () async {
                        try {
                          int userID = await db.signIn(
                              emailController.text, passwordController.text);
                          await Navigator.popAndPushNamed(context, "/home",
                              arguments: userID);
                        } catch (e) {
                          SnackBar(content: Text(e.toString()));
                        }
                      },
                      child: Text(
                        "Giriş Yap",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      )),
                ))
              ],
            ),
          ),
          Container(
            width: 0.2,
            height: 800,
            decoration: BoxDecoration(color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Gap(60),
                Text(
                  "imDBMS'e Kayıt Ol",
                  style: TextStyle(fontSize: 36),
                ),
                Gap(40),
                CustomTextField(
                    title: "Mail Adresi", controller: emailController),
                CustomTextField(title: "Şifre", controller: passwordController),
                CustomTextField(title: "Ad", controller: nameController),
                CustomTextField(title: "Soyad", controller: surnameController),
                CustomTextField(
                    title: "Kullanıcı Adı", controller: nicknameController),
                Gap(40),
                Center(
                    child: SizedBox(
                  width: 200,
                  height: 48,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(yelloish)),
                      onPressed: () async {
                        try {
                          bool result = await db.register(
                              emailController.text,
                              passwordController.text,
                              nicknameController.text,
                              nameController.text,
                              surnameController.text);

                          if (result) {
                            await Navigator.popAndPushNamed(context, "/home");
                          }
                        } catch (e) {
                          SnackBar(content: Text(e.toString()));
                        }
                      },
                      child: Text(
                        "Kayıt Ol",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      )),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    required this.controller,
  });

  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(title),
        ),
        Gap(8),
        SizedBox(
          width: 300,
          height: 80,
          child: TextField(
            controller: controller,
            cursorColor: Colors.black54,
            decoration: InputDecoration(
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                fillColor: Colors.white38,
                filled: true),
          ),
        ),
      ],
    );
  }
}
