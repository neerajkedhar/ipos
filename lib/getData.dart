import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CategoryServices {
  FirebaseFirestore? _instance;

  var listt;
  Future getCatFromFireStore() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection("ipos");
    DocumentSnapshot snapshot = await categories.doc("current-ipos").get();
    var data = snapshot.data() as Map;
    listt = data.values.toList();

    // print(listt[0]);
    // print(listt.length);
    for (var i = 0; i < listt.length; i++) {
      print(listt[i]['ipo-details']);
    }
    return listt;
  }

  funnn() {
    print(listt);
  }

  String returningTitle(int index) {
    return listt[index]['ipo-details'];
  }
}
