import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipos/data/themeChanger.dart';
import 'package:ipos/test/detailsPage.dart';

import '../getData.dart';

class BoardApp extends StatefulWidget {
  const BoardApp({Key? key}) : super(key: key);

  @override
  _BoardAppState createState() => _BoardAppState();
}

class _BoardAppState extends State<BoardApp> {
  CategoryServices cats = new CategoryServices();
  var firestoreDb = FirebaseFirestore.instance.collection("ipos").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("app"),
        ),
        body: FutureBuilder(
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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsPage(index)),
                                );
                              },
                              child: Card(
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
            }));
  }
}
