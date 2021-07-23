import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipos/data/themeChanger.dart';
import 'package:ipos/data/uicolors.dart';

import 'package:ipos/getData.dart';

class LiveIPO extends StatefulWidget {
  const LiveIPO({Key? key}) : super(key: key);

  @override
  _LiveIPOState createState() => _LiveIPOState();
}

class _LiveIPOState extends State<LiveIPO> {
  late Color background;
  late Color foreground;
  late Color accent;
  AppColors colors = AppColors();
  CategoryServices cats = new CategoryServices();
  var firestoreDb = FirebaseFirestore.instance.collection("ipos").snapshots();
  @override
  Widget build(BuildContext context) {
    print("printing asses.....${cats.listt}");
    background = Theme.of(context).brightness == Brightness.dark
        ? colors.darkBG
        : colors.liteBG;
    foreground = Theme.of(context).brightness == Brightness.dark
        ? colors.darkFG
        : colors.liteFG;
    accent = colors.accent;
    return Container(
        color: background,
        child: cats.listt == null
            ? FutureBuilder(
                future: cats.getCatFromFireStore(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text('Please wait its loading...'));
                  } else {
                    if (snapshot.hasError)
                      return Center(child: Text('Error: ${snapshot.error}'));
                    else
                      return Center(
                          child: ListView.builder(
                              itemCount: cats.listt.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    child: GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    color: foreground,
                                    child: Column(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              ThemeChanger.of(context)!
                                                  .changeTheme();
                                            },
                                            child: Text("child")),
                                      ],
                                    ),
                                  ),
                                ));
                              }));
                  }
                })
            : Container(
                child: ListView.builder(
                    itemCount: cats.listt.length,
                    itemBuilder: (context, index) {
                      return Container(
                          child: GestureDetector(
                        onTap: () {},
                        child: Card(
                          color: foreground,
                          child: Column(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    ThemeChanger.of(context)!.changeTheme();
                                  },
                                  child: Text("child")),
                            ],
                          ),
                        ),
                      ));
                    })));
  }
}
