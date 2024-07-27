// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({
    required this.controller,
    this.isOnlyIcon = false,
    super.key,
  });
  final bool isOnlyIcon;
  final Color yelloish = Colors.yellow.shade700;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8, right: 0),
      child: Row(
        children: [
          Gap(16),
          isOnlyIcon
              ? Container()
              : Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SearchBar(
                        onSubmitted: (value) async {
                          await Navigator.pushNamed(context, "/search",
                              arguments: value);
                        },
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                        trailing: [Icon(Icons.search)],
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                        overlayColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        controller: controller,
                        hintText: "Film arayın...",
                        hintStyle: WidgetStatePropertyAll(
                            TextStyle(color: Colors.grey.shade900)),
                      ),
                      Spacer(),
                      InkWell(
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onDoubleTap: () async =>
                            await Navigator.pushNamed(context, "/myprofile"),
                        child: Container(
                          width: 140,
                          height: 58,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(),
                              Gap(8),
                              Text(
                                "Hesabım",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(16),
                      InkWell(
                        onDoubleTap: () async =>
                            await Navigator.pushNamedAndRemoveUntil(
                                context, "/auth", ModalRoute.withName('/')),
                        child: Container(
                          width: 140,
                          height: 58,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              Gap(8),
                              Text(
                                "Çıkış Yap",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
