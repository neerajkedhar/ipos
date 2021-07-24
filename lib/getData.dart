import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CategoryServices {
  FirebaseFirestore? _instance;

  var liveIPOlist;
  Future getFromLiveIPOFireStore() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection("ipos");
    DocumentSnapshot snapshot = await categories.doc("current-ipos").get();
    var data = snapshot.data() as Map;
    liveIPOlist = data.values.toList();

    for (var i = 0; i < liveIPOlist.length; i++) {
      print(liveIPOlist[i]['ipo-details']);
    }
    getFromUpcomingIPOFireStore();
    return liveIPOlist;
  }

  var upcomingIPOList;
  Future getFromUpcomingIPOFireStore() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection("ipos");
    DocumentSnapshot snapshot = await categories.doc("upcoming-ipo").get();
    var data = snapshot.data() as Map;
    upcomingIPOList = data.values.toList();
    print(upcomingIPOList);

    // for (var i = 0; i < liveIPOlist.length; i++) {
    //   print(liveIPOlist[i]['ipo-details']);
    // }
    return liveIPOlist;
  }
}
