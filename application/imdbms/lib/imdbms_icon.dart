// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImdbmsIcon extends StatelessWidget {
  ImdbmsIcon({
    super.key,
  });

  final Color yelloish = Colors.yellow.shade700;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onDoubleTap: () async =>
          await Navigator.popAndPushNamed(context, "/home"),
      child: Container(
          margin: EdgeInsets.only(left: 16, top: 12, bottom: 12),
          width: 100,
          height: 44,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: yelloish),
          child: Center(
              child: Text(
            "imDBMS",
            style: GoogleFonts.anton(
                color: Colors.black, letterSpacing: 0.5, fontSize: 24),
          ))),
    );
  }
}
