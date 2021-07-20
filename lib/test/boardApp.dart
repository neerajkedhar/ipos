import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'getData.dart';

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
                                child: Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      cats.funnn();
                                    },
                                    child: Text("child")),
                                Text(cats.returningTitle(index))
                              ],
                            ));
                          })); // snapshot.data  :- get your object which is pass from your downloadData() function
              }
            }));
  }

  FirebaseFirestore? _instance;
  var listt;
  // List<Category> _categories = [];
  Future<String>? getCatFromFireStore() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection("ipos");
    DocumentSnapshot snapshot = await categories.doc("current-ipos").get();
    var data = snapshot.data() as Map;
    listt = data.values.toList();
    // var categoriesdata = data['zomato'] as List<dynamic>;
    print(listt[0]);
    print(listt.length);
    for (var i = 0; i < listt.length; i++) {
      print(listt[i]['name']);
    }
    return listt;
  }
}
