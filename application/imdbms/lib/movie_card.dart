// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MovieCard extends StatelessWidget {
  MovieCard({
    required this.filmID,
    required this.name,
    required this.point,
    this.like = false,
    this.wathced = false,
    this.showIcons = true,
    super.key,
  });

  final int filmID;
  final String name;
  final double point;
  final bool showIcons;
  final bool like;
  final bool wathced;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: const Color.fromARGB(46, 158, 158, 158),
      splashColor: Colors.transparent,
      onDoubleTap: () async =>
          await Navigator.pushNamed(context, "/movie", arguments: filmID),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: 160,
          height: 360,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10),
              Container(
                width: 160,
                height: 250,
                decoration: BoxDecoration(
                    color: Colors.yellow.shade200,
                    borderRadius: BorderRadius.circular(4)),
                child: Stack(
                  children: [
                    showIcons
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.checklist_rtl_sharp,
                                    color: wathced ? Colors.green : Colors.grey,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite,
                                    color: like ? Colors.red : Colors.grey,
                                  ))
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
              Gap(12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  "imDBMS: $point",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Gap(2),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                child: AutoSizeText(
                  maxLines: 2,
                  name,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
